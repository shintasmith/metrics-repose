default['repose']['version'] = '7.3.5.0'
default['repose']['connection_timeout'] = 30_000 # in millis
default['repose']['read_timeout'] = 30_000 # in millis
default['repose']['client_request_logging'] = true
default['repose']['jvm_minimum_heap_size'] = '4g'
default['repose']['jvm_maximum_heap_size'] = '4g'
default['repose']['jvm_maximum_file_descriptors'] = '65535'

default['repose']['ingest']['container_port'] = 9001
default['repose']['query']['container_port'] = 9011
default['repose']['graphite_port'] = '2003'

default['repose']['slf4j_http_logging']['format'] = '<![CDATA[
            {"received": "%t", "duration": "%T", "method": "%m", "url": "%U", "status": "%s", "remote_ip": "%a", "local_ip": "%A", "server_port": "%p", "request.accept": "%{accept}i", "request.accept-encoding": "%{accept-encoding}i", "request.Connection": "%{Connection}i", "request.Content-Encoding": "%{Content-Encoding}i", "request.Content-Length": "%{Content-Length}i", "request.Content-Type": "%{Content-Type}i", "request.Method": "%{method}i", "request.Host": "%{Host}i", "request.query_string": "%q", "request.Received": "%{Received}i", "request.SSLClientCertStatus": "%{SSLClientCertStatus}i", "request.SSLClientCipher": "%{SSLClientCipher}i", "request.SSLSessionID": "%{SSLSessionID}i", "request.trans-id": "%{trans-id}i", "request.URL": "%U", "request.User-Agent": "%{user-agent}i", "request.X-Cluster-Client-Ip": "%{X-Cluster-Client-Ip}i", "request.X-Forwarded-For": "%{X-Forwarded-For}i", "request.X-Forwarded-Port": "%{X-Forwarded-Port}i", "request.X-Forwarded-Proto": "%{X-Forwarded-Proto}i", "request.via": "%{via}i", "request.x-authorization": "%{x-authorization}i", "request.x-default-region": "%{x-default-region}i", "request.x-pp-groups": "%{x-pp-groups}i", "request.x-pp-user": "%{x-pp-user}i", "request.x-real-ip": "%{x-real-ip}i", "request.x-roles": "%{x-roles}i", "request.x-tenant-id": "%{x-tenant-id}i", "request.x-tenant-name": "%{x-tenant-name}i", "request.x-user-id": "%{x-user-id}i", "request.x-user-name": "%{x-user-name}i", "response.Content-Length": "%{content-length}o", "response.Content-Type": "%{content-type}o", "response.Date": "%{date}o", "response.server": "%{server}o"}
            ]]>'

default['repose']['filters'] = %w(
  slf4j-http-logging
  merge-header
  cors
  header-normalization
  add-header
  keystone-v2
  ip-identity
  rate-limiting
  api-validator
)
default['repose']['services'] = %w(
  dist-datastore
  http-connection-pool
)

default['repose']['http_connection_pool']['chunked_encoding'] = false
default['repose']['http_connection_pool']['socket_timeout'] = 600_000 # in millis
default['repose']['http_connection_pool']['connection_timeout'] = 30_000 # in millis
default['repose']['http_connection_pool']['max_total'] = 400
default['repose']['http_connection_pool']['max_per_route'] = 400

default['repose']['merge_header']['cluster_id'] = ['all']
default['repose']['merge_header']['response_headers'] = ['Access-Control-Allow-Methods', 'Vary']

default['repose']['cors']['cluster_id'] = ['all']
default['repose']['cors']['allowed_methods'] = %w(
  GET
  POST
)

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

default['repose']['add_header']['cluster_id'] = ['all']
default['repose']['add_header']['requests'] = [{
  name:      'content-type',
  quality:   '1',
  overwrite: 'false',
  value:     'application/json'
}]

default['repose']['add_header']['responses'] = [{
  name:      'content-type',
  quality:   '1',
  overwrite: 'false',
  value:     'application/json'
}]

default['repose']['ip_user']['cluster_id'] = ['all']

default['repose']['ip_identity']['cluster_id'] = ['all']
default['repose']['ip_identity']['quality'] = 0.2
default['repose']['ip_identity']['white_list_quality'] = 1.0
default['repose']['ingest']['ip_identity']['white_list_ip_addresses'] = ['127.0.0.1']
default['repose']['query']['ip_identity']['white_list_ip_addresses'] = ['127.0.0.1']

default['repose']['upstart']['pre-stop'] = nil
default['repose']['upstart']['post-start'] = nil
