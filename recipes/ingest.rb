if %w(stage prod perf01 qe01 qe02).any? { |e| e.include?(node.environment) }
  keystone_v2_credentials = Chef::EncryptedDataBagItem.load('blueflood', "repose_#{node.environment}")
  node.default['repose']['keystone_v2']['identity_username'] = keystone_v2_credentials['username']
  node.default['repose']['keystone_v2']['identity_password'] = keystone_v2_credentials['password']
end

node.default['repose']['cluster_ids'] = ['blueflood-ingest']

repose_peers = Array.new
node['blueflood']['ingest_servers'].each do |server|
  repose_peers.push({
    'cluster_id' => node['repose']['cluster_ids'].first,
    'id' => server.to_s,
    'hostname' => server.to_s,
    'port' => node['repose']['ingest']['container_port']
    })
  end
node.default['repose']['peers'] = repose_peers

node.default['repose']['endpoints'] = [
    {
    'cluster_id' => 'blueflood-ingest',
    'id' => 'blueflood-ingest',
    'protocol' => 'http',
    'hostname' => 'localhost',
    'root_path' => '',
    'port' => 2440
    }
  ]
node.default['repose']['slf4j_http_logging']['id'] = 'ingest-repose-http-log'
node.default['repose']['keystone_v2']['white_list'] = %w(
  /blueflood-ingest.wadl$
)
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
node.default['repose']['api_validator']['enable_rax_roles'] = true
node.default['repose']['api_validator']['wadl'] = 'blueflood-ingest.wadl'
node.default['repose']['api_validator']['dot_output'] = nil

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
        'uri-regex' => '/v[0-9.]+/((hybrid:)?[0-9]+)/.+',
        'http-methods' => 'ALL',
        'unit' => 'MINUTE',
        'value' => 10000
      }
    ]
  },
  { 'id' => 'unlimited',
    'groups' => 'unlimited',
    'default' => false,
    'limits' => []
  }
]
