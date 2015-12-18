if %w(stage prod).any? { |e| e.include?(node.chef_environment) }
  keystone_v2_credentials = Chef::EncryptedDataBagItem.load('blueflood', "repose_ingest_#{node['environment']}")
  node.set['repose']['keystone_v2']['identity_username'] = keystone_v2_credentials['username']
  node.set['repose']['keystone_v2']['identity_password'] = keystone_v2_credentials['password']
end
