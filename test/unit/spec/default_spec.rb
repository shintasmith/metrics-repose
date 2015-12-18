require 'chefspec'
require_relative 'spec_helper'

describe 'metrics-repose::default' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'includes the `repose::default` recipe' do
    expect(chef_run).to include_recipe('repose::default')
  end

  it 'includes the `java::default` recipe' do
    expect(chef_run).to include_recipe('java::default')
  end
end
