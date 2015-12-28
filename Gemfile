# encoding: UTF-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

source 'https://rubygems.org'

group :style do
  gem 'foodcritic'
  gem 'rubocop'
end

group :spec do
  gem 'berkshelf'
  gem 'chefspec'
end

group :integration do
  gem 'test-kitchen', '~> 1.4.0'
end

group :integration_vagrant do
  gem 'kitchen-vagrant'
  gem 'vagrant-wrapper'
end

group :integration_rackspace do
  gem 'kitchen-rackspace'
end

group :development do
  gem 'thor-scmversion'
end
