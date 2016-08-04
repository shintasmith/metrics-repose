# encoding: UTF-8
# License:: Apache License, Version 2.0
#

require_relative 'spec_helper'

describe file('/etc/sysconfig/repose') do
  it { should be_file }
  it { should be_mode 644 }
end

describe file('/etc/repose/system-model.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
end

describe file('/etc/repose/container.cfg.xml') do
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
  its(:content) { should match %r{-repose-http-log\" level\=\"info\" additivity\=\"false\"\>} }
end

describe service('repose-valve') do
  it { should be_enabled }
end
