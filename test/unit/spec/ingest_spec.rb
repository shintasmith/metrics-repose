require 'chefspec'
require_relative 'spec_helper'

describe 'metrics-repose::ingest' do
  before { stub_resources }
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
      node.default['blueflood']['ingest_servers'] = ['127.0.0.1']
    end.converge(described_recipe)
  end

  it 'include recipe repose::install' do
    expect(chef_run).to include_recipe('repose::install')
  end

  it 'create cookbook file /etc/repose/blueflood-ingest.wadl' do
    expect(chef_run).to create_cookbook_file('/etc/repose/blueflood-ingest.wadl')
  end
  it 'create file /var/log/repose/blueflood-ingest.log' do
    expect(chef_run).to create_file('/var/log/repose/blueflood-ingest.log')
  end
end
