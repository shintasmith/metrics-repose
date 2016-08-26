require 'uri'
include_recipe 'repose::default'

# NOTE repose::default is mostly copied here due to the following code (which makes wrapping nigh impossible):
# https://github.com/rackerlabs/cookbook-repose/blob/31a561526a1d393b1d7ef8370be26b3999e01f84/recipes/default.rb#L93

template '/etc/init/repose-valve.conf' do
  source 'repose-valve.upstart.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

# HACK: before getting upstream to have different startup scripts supported
# delete /etc/init.d/repose-valve installed by package
file '/etc/init.d/repose-valve' do
  action :delete
  manage_symlink_source true
end
# replace with a symlink to /lib/init/upstart-job
link '/etc/init.d/repose-valve' do
  to '/lib/init/upstart-job'
end

service 'repose-valve' do
  supports restart: true, status: true
  action [:enable, :start]
  provider Chef::Provider::Service::Upstart
end

template '/etc/repose/metrics.cfg.xml' do
  source 'metrics.cfg.xml.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

unless node['repose']['cluster_id'].nil?
  log "Please note that node['repose']['cluster_id'] is deprecated. We've set node['repose']['cluster_ids'] to [#{node['repose']['cluster_id']}] in an effort to maintain compatibility with earlier versions. This functionality will be removed in a future version."
  node.normal['repose']['cluster_ids'] = [node['repose']['cluster_id']]
end

directory node['repose']['config_directory'] do
  owner node['repose']['owner']
  group node['repose']['group']
  mode '0755'
end

services = node['repose']['services'].reject { |x| x == 'http-connection-pool' || x == 'response-messaging' }
service_cluster_map = {
  'dist-datastore' => node['repose']['dist_datastore']['cluster_id']
}

# update for stage/prod port
node.default['repose']['endpoints'] = [{
  cluster_id: 'repose',
  id: 'public_api',
  protocol: 'http',
  hostname: 'localhost',
  port: '2500',
  root_path: '/',
  default: true
}]

# NOTE these hash keys should be left as strings or system-model.cfg.xml.erb will break
filter_cluster_map = {
  'header-normalization'   => node['repose']['header_normalization']['cluster_id'],
  'add-header'             => node['repose']['add_header']['cluster_id'],
  'slf4j-http-logging'     => node['repose']['slf4j_http_logging']['cluster_id'],
  'keystone-v2'            => node['repose']['keystone_v2']['cluster_id'],
  'ip-identity'            => node['repose']['ip_identity']['cluster_id'],
  'rate-limiting'          => node['repose']['rate_limiting']['cluster_id'],
  'api-validator'          => node['repose']['api_validator']['cluster_id']
}

filter_uri_regex_map = {
  'header-normalization'   => node['repose']['header_normalization']['uri_regex'],
  'add-header'             => node['repose']['add_header']['uri_regex'],
  'slf4j-http-logging'     => node['repose']['slf4j_http_logging']['uri_regex'],
  'keystone-v2'            => node['repose']['keystone_v2']['uri_regex'],
  'ip-identity'            => node['repose']['ip_identity']['uri_regex'],
  'rate-limiting'          => node['repose']['rate_limiting']['uri_regex'],
  'api-validator'          => node['repose']['api_validator']['uri_regex']
}
