require 'chefspec'
require_relative 'spec_helper'

describe 'metrics-repose' do
  before { stub_resources }
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }

  it 'includes the repose::default recipe' do
    expect(chef_run).to include_recipe('repose::default')
  end

  it 'creates a template /etc/init/repose-valve.conf' do
    expect(chef_run).to create_template('/etc/init/repose-valve.conf')
  end
  it 'deletes the old init start script at /etc/init.d/repose-valve' do
    expect(chef_run).to delete_file('/etc/init.d/repose-valve')
  end
  it 'creates a symlink to the upstart template' do
    expect(chef_run).to create_link('/etc/init.d/repose-valve').with(to: '/lib/init/upstart-job')
  end

  it 'enables a service called repose-valve' do
    expect(chef_run).to enable_service('repose-valve')
  end
  it 'starts a service called repose-valve' do
    expect(chef_run).to start_service('repose-valve')
  end

  it 'creates a template /etc/repose/metrics.cfg.xml' do
    expect(chef_run).to create_template('/etc/repose/metrics.cfg.xml')
  end
  it 'creates a directory /etc/repose' do
    expect(chef_run).to create_directory('/etc/repose')
  end
end
