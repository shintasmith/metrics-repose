# encoding: UTF-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

source 'https://rubygems.org'

gem 'berkshelf'
gem 'chef', '~> 12.8.1'
gem 'chef-sugar'
gem 'rake'

group :style do
  gem 'foodcritic'
  gem 'rubocop'
end

group :spec do
  gem 'chefspec'
  gem 'rubocop-rspec'
end

group :integration do
  gem 'test-kitchen', '~> 1.4.1'
end

group :vagrant do
  gem 'kitchen-vagrant'
  gem 'vagrant-cachier'
  gem 'vagrant-wrapper'
end

group :integration_docker do
  gem 'kitchen-docker', '~> 2.3'
end
