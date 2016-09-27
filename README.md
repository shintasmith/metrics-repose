[![Build Status](https://travis-ci.org/mmi-cookbooks/metrics-repose.svg)](https://travis-ci.org/mmi-cookbooks/metrics-repose)
[![Code Climate](https://codeclimate.com/github/mmi-cookbooks/metrics-repose/badges/gpa.svg)](https://codeclimate.com/github/mmi-cookbooks/metrics-repose)
[![Coverage Status](https://coveralls.io/repos/mmi-cookbooks/metrics-repose/badge.svg?branch=master&service=github)](https://coveralls.io/github/mmi-cookbooks/metrics-repose?branch=master)

# metrics-repose

This cookbook wraps the standard [repose cookbook](https://github.com/rackerlabs/cookbook-repose) and applies Rackspace Metrics particular settings and filters for query and ingest nodes.  Metrics has two separate repose configurations for query and ingest nodes.

To use this cookbook you'll need to add it via [berkshelf](http://berkshelf.com/) or otherwise get it into your cookbooks dir.  You'll also need to reference the base repose cookbook.

## Supported Platforms

Other platforms are untested.

- Ubuntu 14.04

## Attributes

See the upstream repose cookbook for reference on available attributes (there are a lot).   If setting attributes to override the upstream cookbook, they are set in either attributes/default.rb, recipes/ingest.rb or recipes/query.rb.

## Usage

Include `metrics-repose` in your node's `run_list`:

### metrics-repose::query

```json
{
  "run_list": [
    "recipe[metrics-repose::query]"
  ]
}
```

### metrics-repose::ingest

```json
{
  "run_list": [
    "recipe[metrics-repose::ingest]"
  ]
}
```

### metrics-repose::default

```json
{
  "run_list": [
    "recipe[metrics-repose::default]"
  ]
}
```

## Releasing
To release a new version of this cookbook, do the following:

1. update the CHANGELOG.md file with the new version and changes
2. update the metadata.rb file
3. commit all changes to master (or merge PR, etc.)
4. tag the repo with the matching version for this release

Then you probably want to update some Berksfiles :smile:

## Building and Testing

### Requirements
1. Vagrant
Download it from: https://www.vagrantup.com/downloads.html
2. Virtual Box
Download it from: https://www.virtualbox.org/wiki/Downloads

Optionally for OSX, you can use homebrew install to vagrant and virtualbox together. 

- http://brew.sh/index.html
- http://sourabhbajaj.com/mac-setup/Vagrant/README.html

```
brew cask install virtualbox
brew cask install vagrant
```

## Kitchen and Travis
You can run 'kitchen test' or 'kitchen converge [ingest|query]' to test the cookbook.  This cookbook will run some lint checking on TravisCI when pushed to github.

```
# useful kitchen commands
kitchen create 		# builds the basic VM
kitchen converge 	# tests chef convergence
kitchen verify 		# runs integration tests
kitchen destroy 	# clean everything up
kitchen test 		# basically runs through those 4 steps above) - but does a destroy at the end
kitchen login 		# will log you into the VM in any of the first 4 steps

# useful vagrant commands
vagrant global-status 			# list VMs info and states
vagrant ssh <machine_id> 		# ssh to the vm
vagrant ssh <machine_id> -c "sudo cat /some_file" > some_file # cat a file on the vm to a local file
vagrant halt <machine_id> 		# stop the vm
vagrant destroy <machine_id> 	# destroy the vm, but you should preferably use `kitchen destroy` if possible
```
