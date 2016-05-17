node.default['repose']['cluster_ids'] = ['blueflood-ingest']
node.default['repose']['content_body_read_limit'] = 1_048_576

cookbook_file '/etc/repose/blueflood-ingest.wadl'

if %w(stage prod perf01 qe01 qe02).any? { |e| e.include?(node.environment) }
  credentials = Chef::EncryptedDataBagItem.load('blueflood', "repose_#{node.environment}")
  node.default['repose']['keystone_v2']['username_admin'] = credentials['username']
  node.default['repose']['keystone_v2']['password_admin'] = credentials['password']
end

repose_peers = []
node['blueflood']['ingest_servers'].each do |server|
  repose_peers.push('cluster_id' => node['repose']['cluster_ids'].first,
                    'id' => server.to_s,
                    'hostname' => server.to_s,
                    'port' => node['repose']['ingest']['container_port'])
end
node.default['repose']['peers'] = repose_peers

file 'var/log/repose/blueflood-ingest.log' do
  user 'root'
  group 'root'
  mode 0644
end
node.default['repose']['appenders'] = ['<RollingFile name="blueflood-ingest" fileName="/var/log/repose/blueflood-ingest.log"
                     filePattern="/var/log/repose/blueflood-ingest-%d{yyyy-MM-dd_HHmmss}.log">
            <PatternLayout pattern="%m%n"/>
            <Policies>
                <SizeBasedTriggeringPolicy size="1024 MB"/>
            </Policies>
            <DefaultRolloverStrategy max="20"/>
        </RollingFile>']
node.default['repose']['loggers'] = ['<Logger name="ingest-repose-http-log" level="info">
            <AppenderRef ref="blueflood-ingest"/>
        </Logger>']

node.default['repose']['endpoints'] = [
  {
    'cluster_id' => 'blueflood-ingest',
    'id' => 'blueflood-ingest',
    'protocol' => 'http',
    'hostname' => 'localhost',
    'root_path' => '',
    'port' => 2440,
    'default' => true
  }
]
node.default['repose']['slf4j_http_logging']['id'] = 'ingest-repose-http-log'
node.default['repose']['keystone_v2']['groups_in_header'] = true
node.default['repose']['keystone_v2']['uri'] = 'https://identity.api.rackspacecloud.com'
node.default['repose']['keystone_v2']['cache'] = {
  'timeout_variability' => 10,
  'token_timeout' => 600,
  'group_timeout' => 600,
  'endpoints_timeout' => 600
}
node.default['repose']['http_connection_pool']['chunked_encoding'] = false
node.default['repose']['dist_datastore']['port'] = 9002
node.default['repose']['dist_datastore']['cluster_id'] = ['blueflood-ingest']
node.default['repose']['api_validator']['cluster_id'] = ['all']
node.default['repose']['api_validator']['wadl'] = 'blueflood-ingest.wadl'
node.default['repose']['api_validator']['dot_output'] = '/tmp/blueflood-ingest.wadl.dot'
node.default['repose']['api_validator']['enable_rax_roles'] = true
node.default['repose']['api_validator']['check_well_formed'] = false
node.default['repose']['api_validator']['check_grammars'] = true
node.default['repose']['api_validator']['check_elements'] = true
node.default['repose']['api_validator']['check_plain_params'] = true
node.default['repose']['api_validator']['do_xsd_grammar_transform'] = true
node.default['repose']['api_validator']['enable_pre_process_extension'] = true
node.default['repose']['api_validator']['remove_dups'] = true
node.default['repose']['api_validator']['xpath_version'] = '2'
node.default['repose']['api_validator']['xsl_engine'] = 'XalanC'
node.default['repose']['api_validator']['join_xpath_checks'] = false

node.default['repose']['rate_limiting']['cluster_id'] = ['all']
node.default['repose']['rate_limiting']['uri_regex'] = '/v[0-9.]+/(hybrid:)?[0-9]+/limits/?'
node.default['repose']['rate_limiting']['include_absolute_limits'] = true
node.default['repose']['rate_limiting']['global_limit_id'] = 'global'
node.default['repose']['rate_limiting']['global_limit_uri'] = '*'
node.default['repose']['rate_limiting']['global_limit_uri_regex'] = '.*'
node.default['repose']['rate_limiting']['global_limit_value'] = 1000
node.default['repose']['rate_limiting']['global_limit_unit'] = 'MINUTE'
node.default['repose']['rate_limiting']['limit_groups'] = [
  { 'id' => 'main',
    'groups' => 'IP_Standard',
    'default' => true,
    'limits' => [
      { 'id' => '/version/tenantId/*',
        'uri' => '/version/tenantId/*',
        'uri_regex' => '/v[0-9.]+/((hybrid:)?[0-9]+)/.+',
        'http_methods' => 'ALL',
        'unit' => 'MINUTE',
        'value' => 1000
      }
    ]
  },
  { 'id' => 'unlimited',
    'groups' => 'unlimited',
    'default' => false,
    'limits' => []
  }
]
