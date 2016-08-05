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
  header-normalization
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
default['repose']['http_connection_pool']['max_total'] = 16000
default['repose']['http_connection_pool']['max_per_route'] = 16000

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

default['repose']['ip_user']['cluster_id'] = ['all']

default['repose']['ip_identity']['cluster_id'] = ['all']
default['repose']['ip_identity']['quality'] = 0.2
default['repose']['ip_identity']['white_list_quality'] = 1.0
default['repose']['ip_identity']['white_list_ip_addresses'] = ['127.0.0.1', '69.20.62.248/29', '10.190.252.12/32', '10.190.252.10/32']
