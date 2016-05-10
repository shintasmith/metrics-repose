default['repose']['cluster_ids'] = ['blueflood-query']
# TODO loop through with query_servers
default['repose']['peers'] = [{
    'cluster_id' => 'blueflood-query',
    'id' => '10.209.131.203',
    'hostname' => '10.209.131.203',
    'port' => 9001
    },
    {
    'cluster_id' => 'blueflood-query',
    'id' => '10.209.132.144',
    'hostname' => '10.209.132.144',
    'port' => 9001
    }]
default['repose']['endpoints'] = [{
    'cluster_id' => 'blueflood-query',
    'id' => 'blueflood-query',
    'protocol' => 'http',
    'hostname' => 'localhost',
    'root_path' => '',
    'port' => 2500
    }]

default['repose']['slf4j_http_logging']['id'] = 'query-repose-http-log'

default['repose']['keystone_v2']['username_admin'] = 'bfprod'
default['repose']['keystone_v2']['password_admin'] = 'testing'
default['repose']['keystone_v2']['white_list'] = %w(
  /blueflood-query\.wadl$
)
default['repose']['keystone_v2']['cache'] = {
    'timeout_variability' => 10,
    'token_timeout' => 600,
    'group_timeout' => 600,
    'endpoints_timeout' => 600
    }
default['repose']['tenant_handling']['send_all_tenant_ids'] = true
default['repose']['tenant_handling']['validate_tenant'] = {
    'url_extraction_regex' => '.*'
    }
default['repose']['tenant_handling']['send_tenant_id_quality'] = {
    'default' => '1.0',
    'roles' => '0.5',
    'uri' => '0.5'
    }

default['repose']['http_connection_pool']['chunked_encoding'] = false
default['repose']['dist_datastore']['port'] = 9012

default['repose']['ip_user']['cluster_id'] = ['all']

default['repose']['api_validator']['cluster_id'] = ['all']
default['repose']['api_validator']['wadl'] = 'blueflood-query.wadl'
default['repose']['api_validator']['dot_output'] = '/tmp/blueflood-query.wadl.dot'
default['repose']['api_validator']['enable_rax_roles'] = true
default['repose']['api_validator']['check_well_formed'] = false
default['repose']['api_validator']['check_grammars'] = true
default['repose']['api_validator']['check_elements'] = true
default['repose']['api_validator']['check_plain_params'] = true
default['repose']['api_validator']['do_xsd_grammar_transform'] = true
default['repose']['api_validator']['enable_pre_process_extension'] = true
default['repose']['api_validator']['remove_dups'] = true
default['repose']['api_validator']['xpath_version'] = '2'
default['repose']['api_validator']['xsl_engine'] = 'XalanC'
default['repose']['api_validator']['join_xpath_checks'] = false

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
