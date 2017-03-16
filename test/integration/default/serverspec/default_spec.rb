# encoding: UTF-8
# License:: Apache License, Version 2.0
#

require_relative 'spec_helper'

describe file('/etc/repose') do
  it { should be_directory }
  it { should be_mode 755 }
end

describe file('/etc/repose/slf4j-http-logging.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
end
describe file('/etc/repose/merge-header.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
end
describe file('/etc/repose/cors.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
end
describe file('/etc/repose/container.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
end
describe file('/etc/repose/dist-datastore.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
end
describe file('/etc/repose/http-connection-pool.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
end
describe file('/etc/repose/ip-identity.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
end
describe file('/etc/keystone-v2.cfg.xml') do
  it { should be_file }
  it { should be_mode 640 }
end
describe file('/etc/validator.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
end
describe file('/etc/rate-limiting.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
end
describe file('/etc/repose/system-model.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
end

describe file('/etc/repose/log4j2.xml') do
  it { should be_file }
  it { should be_mode 644 }
  its(:content) { should match(/-repose-http-log\" level\=\"info\" additivity\=\"false\"\>/) }
end

describe service('repose-valve') do
  it { should be_enabled }
  it { should be_started }
end
