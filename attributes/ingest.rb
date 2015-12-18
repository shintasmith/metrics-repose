default['repose']['cluster_ids'] = ['blueflood-ingest']
# TODO loop through with ingest_servers
default['repose']['peers'] = [
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
default['repose']['endpoints'] = [
    {
    'cluster_id' => 'blueflood-ingest',
    'id' => 'blueflood-ingest',
    'protocol' => 'http',
    'hostname' => 'localhost',
    'root_path' => '',
    'port' => 2440
    }
  ]
default['repose']['slf4j_http_logging']['id'] = 'query-repose-http-log'
default['repose']['keystone_v2']['username_admin'] = 'bfprod'
default['repose']['keystone_v2']['password_admin'] = 'testing'
default['repose']['keystone_v2']['white_list'] = %w(
  /blueflood-ingest.wadl$
)
default['repose']['keystone_v2']['cache'] = {
    'timeout_variability' => 10,
    'token_timeout' => 600,
    'group_timeout' => 600,
    'endpoints_timeout' => 600
    }
default['repose']['http_connection_pool']['chunked_encoding'] = false
default['repose']['dist_datastore']['port'] = 9002
default['repose']['api_validator']['cluster_id'] = ['all']
default['repose']['api_validator']['enable_rax_roles'] = true
default['repose']['api_validator']['wadl'] = 'blueflood-ingest.wadl'
default['repose']['api_validator']['dot_output'] = nil

default['repose']['rate_limiting']['cluster_id'] = ['all']
default['repose']['rate_limiting']['uri_regex'] = '/v[0-9.]+/(hybrid:)?[0-9]+/limits/?'
default['repose']['rate_limiting']['include_absolute_limits'] = true
default['repose']['rate_limiting']['global_limit_id'] = 'global'
default['repose']['rate_limiting']['global_limit_uri'] = '*'
default['repose']['rate_limiting']['global_limit_uri_regex'] = '.*'
default['repose']['rate_limiting']['global_limit_value'] = 1000
default['repose']['rate_limiting']['global_limit_unit'] = 'MINUTE'
default['repose']['rate_limiting']['limit_groups'] = [
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
