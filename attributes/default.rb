default['repose']['version'] = '7.3.3.2'
default['repose']['connection_timeout'] = 30_000 # in millis
default['repose']['read_timeout'] = 600_000 # in millis
default['repose']['client_request_logging'] = true

default['repose']['ingest']['container_port'] = 9001
default['repose']['query']['container_port'] = 9011

default['repose']['slf4j_http_logging']['format'] ='<![CDATA[
            { "received": "%t", "duration": "%T", "method": "%m", "path": "%U", "status": "%s", "remote_ip": "%a", "x_forwarded_for": "%{x-forwarded-for}i", "x_real_ip": "%{x-real-ip}i", "remote_host": "%h", "remote_user":            "%u", "response_size": "%b", "query_string": "%q", "local_ip": "%A", "server_port": "%p", "user_agent":            "%{user-agent}i", "content_type": "%{content-type}i", "accept": "%{accept}i", "rate_limit_group":            "%{X-PP-Groups}i" }
            ]]>'

default['repose']['filters'] = %w(
  slf4j-http-logging
  header-normalization
  keystone-v2
  ip-user
  rate-limiting
  api-validator
)
default['repose']['services'] = %w(
  dist-datastore
  http-connection-pool
)
default['repose']['http_connection_pool']['chunked_encoding'] = false
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

default['repose']['ip_user']['cluster_id'] = ['all']

##### check on...
# default['repose']['connection_pool']['socket_timeout'] = 600_000 # in millis
# default['repose']['connection_pool']['connection_timeout'] = 30_000 # in millis
# default['repose']['connection_pool']['max_total'] = 1000
# default['repose']['connection_pool']['max_per_route'] = 500
#
# default['repose']['header_normalization']['cluster_id'] = ['all']
# default['repose']['header_normalization']['uri_regex'] = nil
# default['repose']['header_normalization']['whitelist'] = []
#
# default['repose']['jvm_minimum_heap_size'] = '2g'
# default['repose']['jvm_maximum_heap_size'] = '4g'
# default['repose']['jvm_maximum_file_descriptors'] = '65535'

# default['repose']['rate_limiting']['cluster_id'] = ['all']
# default['repose']['rate_limiting']['uri_regex'] = '/v[0-9.]+/(hybrid:)?[0-9]+/limits/?'
# default['repose']['rate_limiting']['include_absolute_limits'] = true
# default['repose']['rate_limiting']['global_limit_id'] = 'global'
# default['repose']['rate_limiting']['global_limit_uri'] = '*'
# default['repose']['rate_limiting']['global_limit_uri_regex'] = '.*'
# default['repose']['rate_limiting']['global_limit_value'] = 1000
# default['repose']['rate_limiting']['global_limit_unit'] = 'MINUTE'
# default['repose']['rate_limiting']['limit_groups'] = [
#  { 'id' => 'main',
#    'groups' => 'IP_Standard',
#    'default' => true,
#    'limits' => [
#      { 'id' => '/version/tenantId/*',
#        'uri' => '/version/tenantId/*',
#        'uri-regex' => '/v[0-9.]+/((hybrid:)?[0-9]+)/.+',
#        'http-methods' => 'ALL',
#        'unit' => 'MINUTE',
#        'value' => 10000
#      }
#    ]
#  },
#  { 'id' => 'unlimited',
#    'groups' => 'unlimited',
#    'default' => false,
#    'limits' => []
#  }
# ]
#
