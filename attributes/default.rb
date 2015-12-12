# tweaks to existing repose attributes

default['repose']['peers'] = [{
  cluster_id: 'repose',
  id: 'repose_node',
  hostname: 'localhost',
  port: '9011'
}]

default['repose']['filters'] = %w(
  header-normalization
  keystone-v2
  ip-identity
  rate-limiting
  api-validator
)

default['repose']['endpoints'] = [{
  cluster_id: 'repose',
  id: 'public_api',
  protocol: 'http',
  hostname: 'localhost',
  port: '2500',
  root_path: '/',
  default: true
}]

default['repose']['connection_timeout'] = 30_000 # in millis
default['repose']['read_timeout'] = 600_000 # in millis

default['repose']['connection_pool']['socket_timeout'] = 600_000 # in millis
default['repose']['connection_pool']['connection_timeout'] = 30_000 # in millis
default['repose']['connection_pool']['max_total'] = 1000
default['repose']['connection_pool']['max_per_route'] = 500

default['repose']['header_normalization']['cluster_id'] = ['all']
default['repose']['header_normalization']['uri_regex'] = nil
default['repose']['header_normalization']['whitelist'] = []

default['repose']['header_normalization']['blacklist'] = [{
  id: 'authorization',
  http_methods: 'ALL',
  headers: %w(
    X-Authorization
    X-Token-Expires
    X-Identity-Status
    X-Impersonator-Id
    X-Impersonator-Name
    X-Impersonator-Roles
    X-Roles
    X-Contact-Id
    X-Device-Id
    X-User-Id
    X-User-Name
    X-PP-User
    X-PP-Groups
    X-Catalog
    X-Subject-Token
    X-Subject-Name
    X-Subject-ID
  )
}]

default['repose']['version'] = '7.3.0.0'
default[:repose][:jvm_minimum_heap_size] = '2g'
default[:repose][:jvm_maximum_heap_size] = '4g'
default[:repose][:jvm_maximum_file_descriptors] = '65535'

default['repose']['owner'] = 'repose'
default['repose']['group'] = 'repose'

default['repose']['keystone_v2']['cluster_id'] = ['all']
default['repose']['keystone_v2']['uri_regex'] = nil

# defaults are for dev/local (recipe overrides with encrypted data bag item by metrics environment)
default['repose']['keystone_v2']['identity_username'] = 'identity_username'
default['repose']['keystone_v2']['identity_password'] = 'identity_p4ssw0rd'

default['repose']['keystone_v2']['identity_uri'] = 'http://localhost:8900/identity'
default['repose']['keystone_v2']['identity_set_roles'] = true
default['repose']['keystone_v2']['identity_set_groups'] = false
default['repose']['keystone_v2']['identity_set_catalog'] = false
default['repose']['keystone_v2']['whitelist_uri_regexes'] = nil
default['repose']['keystone_v2']['tenant_uri_extraction_regex'] = '.*/v1.0/(\d+|[a-zA-Z]+:\d+)/.+'
default['repose']['keystone_v2']['preauthorized_service_admin_role'] = nil
default['repose']['keystone_v2']['token_timeout_variability'] = 15
default['repose']['keystone_v2']['token_timeout'] = 600

default['repose']['ip_identity']['cluster_id'] = ['all']
default['repose']['ip_identity']['quality'] = 0.2
default['repose']['ip_identity']['white_list_quality'] = 1.0
default['repose']['ip_identity']['white_list_ip_addresses'] = ['127.0.0.1']

default['repose']['rate_limiting']['cluster_id'] = ['all']
default['repose']['rate_limiting']['uri_regex'] = '/limits'
default['repose']['rate_limiting']['include_absolute_limits'] = false
default['repose']['rate_limiting']['limit_groups'] = [
  { 'id' => 'limited',
    'groups' => 'limited',
    'default' => true,
    'limits' => [
      { 'id' => 'all',
        'uri' => '*',
        'uri-regex' => '/.*',
        'http-methods' => 'POST PUT GET DELETE',
        'unit' => 'MINUTE',
        'value' => 10
      }
    ]
  },
  { 'id' => 'unlimited',
    'groups' => 'unlimited',
    'default' => false,
    'limits' => []
  }
]

default['repose']['api_validator']['cluster_id'] = ['all']
default['repose']['api_validator']['enable_rax_roles'] = true
default['repose']['api_validator']['wadl'] = nil
default['repose']['api_validator']['dot_output'] = nil
