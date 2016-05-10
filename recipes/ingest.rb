if %w(stage prod perf01 qe01 qe02).any? { |e| e.include?(node.environment) }
  keystone_v2_credentials = Chef::EncryptedDataBagItem.load('blueflood', "repose_#{node.environment}")
  node.set['repose']['keystone_v2']['identity_username'] = keystone_v2_credentials['username']
  node.set['repose']['keystone_v2']['identity_password'] = keystone_v2_credentials['password']
end

node.set['repose']['cluster_ids'] = ['blueflood-ingest']
# TODO loop through with ingest_servers
node.set['repose']['peers'] = [
    {
    'cluster_id' => 'blueflood-ingest',
    'id' => '10.209.64.14',
    'hostname' => '10.209.64.14',
    'port' => 9011
    },
    {
    'cluster_id' => 'blueflood-ingest',
    'id' => '10.209.64.34',
    'hostname' => '10.209.64.34',
    'port' => 9011
    }
  ]
node.set['repose']['endpoints'] = [
    {
    'cluster_id' => 'blueflood-ingest',
    'id' => 'blueflood-ingest',
    'protocol' => 'http',
    'hostname' => 'localhost',
    'root_path' => '',
    'port' => 2440
    }
  ]
node.set['repose']['slf4j_http_logging']['id'] = 'ingest-repose-http-log'
node.set['repose']['keystone_v2']['white_list'] = %w(
  /blueflood-ingest.wadl$
)
node.set['repose']['keystone_v2']['cache'] = {
    'timeout_variability' => 10,
    'token_timeout' => 600,
    'group_timeout' => 600,
    'endpoints_timeout' => 600
    }
node.set['repose']['http_connection_pool']['chunked_encoding'] = false
node.set['repose']['dist_datastore']['port'] = 9002
node.set['repose']['api_validator']['cluster_id'] = ['all']
node.set['repose']['api_validator']['enable_rax_roles'] = true
node.set['repose']['api_validator']['wadl'] = 'blueflood-ingest.wadl'
node.set['repose']['api_validator']['dot_output'] = nil

node.set['repose']['rate_limiting']['cluster_id'] = ['all']
node.set['repose']['rate_limiting']['uri_regex'] = '/v[0-9.]+/(hybrid:)?[0-9]+/limits/?'
node.set['repose']['rate_limiting']['include_absolute_limits'] = true
node.set['repose']['rate_limiting']['global_limit_id'] = 'global'
node.set['repose']['rate_limiting']['global_limit_uri'] = '*'
node.set['repose']['rate_limiting']['global_limit_uri_regex'] = '.*'
node.set['repose']['rate_limiting']['global_limit_value'] = 1000
node.set['repose']['rate_limiting']['global_limit_unit'] = 'MINUTE'
node.set['repose']['rate_limiting']['limit_groups'] = [
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
