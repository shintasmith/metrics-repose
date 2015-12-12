template "#{node['repose']['config_directory']}/log4j2.xml" do
  owner node['repose']['owner']
  group node['repose']['group']
  mode '0644'
  notifies :restart, 'service[repose-valve]'
end
