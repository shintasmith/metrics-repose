require 'chefspec'
require_relative 'spec_helper'

describe 'metrics-repose::filter-keystone-v2' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }
end

describe 'repose::filter-keystone-v2' do
  before { stub_resources }

  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['repose']['version']                                    = '7.2.0.0'
      node.set['repose']['filters']                                    = ['keystone-v2']
    end.converge(described_recipe)
  end

  it 'keystone-v2 has correct namespace for version 7' do
    expect(chef_run).to render_file('/etc/repose/keystone-v2.cfg.xml').with_content(%r{<keystone-v2 xmlns="http:\/\/docs.openrepose.org\/repose\/keystone-v2\/v1.0">})
  end

  it 'keystone-v2 has correct username' do
    expect(chef_run).to render_file('/etc/repose/keystone-v2.cfg.xml').with_content(/<identity-service\s+username="admin"/)
  end

  it 'keystone-v2 has correct password' do
    expect(chef_run).to render_file('/etc/repose/keystone-v2.cfg.xml').with_content(/<identity-service[^<]+password="password"/)
  end

  it 'keystone-v2 has correct uri' do
    expect(chef_run).to render_file('/etc/repose/keystone-v2.cfg.xml').with_content(/<identity-service[^<]+uri="https:\/\/identity.api.rackspacecloud.com\/v2.0"\/)
  end

  it 'keystone-v2 has correct tenant-handling' do
    expect(chef_run).to render_file('/etc/repose/keystone-v2.cfg.xml').with_content(/<tenant-handling >[^<]+<validate-tenant>[^<]+<uri-extraction-regex>\/v2.0\/\(\[\^/\]\+\)\/\.\+<\/uri-extraction-regex>/)
  end
end
