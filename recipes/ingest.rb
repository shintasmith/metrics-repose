node.default['repose']['cluster_ids'] = ['blueflood-ingest']
node.default['repose']['content_body_read_limit'] = 1_048_576

include_recipe 'repose::install'

cookbook_file '/etc/repose/blueflood-ingest.wadl'

if %w(stage prod perf01 perf02 qe01 qe02).any? { |e| e.include?(node.chef_environment) }
  credentials = Chef::EncryptedDataBagItem.load('blueflood', "repose_#{node.chef_environment}")
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

file '/var/log/repose/blueflood-ingest.log' do
  user 'root'
  group 'root'
  mode 0o0644
end
node.default['repose']['appenders'] = ['<RollingFile name="blueflood-ingest" fileName="/var/log/repose/blueflood-ingest.log"
                     filePattern="/var/log/repose/blueflood-ingest-%i.log">
            <PatternLayout pattern="%m%n"/>
            <Policies>
                <SizeBasedTriggeringPolicy size="1024 MB"/>
            </Policies>
            <DefaultRolloverStrategy max="6"/>
        </RollingFile>']
node.default['repose']['loggers'] = ['<Logger name="ingest-repose-http-log" level="info" additivity="false">
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
node.default['repose']['rate_limiting']['use_capture_groups'] = false
node.default['repose']['rate_limiting']['overlimit_429_responsecode'] = true
node.default['repose']['rate_limiting']['global_limits'] = [
  {
    'id' => 'global',
    'uri' => '*',
    'uri-regex' => '.*',
    'value' => 100_000,
    'http-methods' => 'ALL',
    'unit' => 'MINUTE'
  }
]
node.default['repose']['rate_limiting']['limit_groups'] = [
  {
    'id' => 'match-all',
    'groups' => 'IP_Standard',
    'default' => true,
    'limits' => [
      {
        'id' => 'version-tenantId',
        'uri' => '/version/tenantId/*',
        'uri_regex' => '/v[0-9.]+/((hybrid:)?[0-9]+)/.+',
        'http_methods' => 'ALL',
        'unit' => 'MINUTE',
        'value' => 5000
      }
    ]
  },
  {
    'id' => 'maas-prod',
    'groups' => 'IP_Super',
    'default' => false,
    'limits' => [
      {
        'id' => 'near-unlimited',
        'uri' => '/version/tenantId/*',
        'uri_regex' => '/v[0-9.]+/((hybrid:)?[0-9]+)/.+',
        'http_methods' => 'ALL',
        'unit' => 'MINUTE',
        'value' => 100_000
      }
    ]
  }
]

node.default['repose']['keystone_v2']['tenant_handling'] = {
  'validate_tenant' => {
    'url_extraction_regex' => '/v2.0/([^/]+)/.+'
  }
}
node.default['repose']['keystone_v2']['white_list'] = ['/v2.0/?']
