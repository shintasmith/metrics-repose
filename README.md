[![Build Status](https://travis-ci.org/mmi-cookbooks/metrics-repose.svg)](https://travis-ci.org/mmi-cookbooks/metrics-repose)
[![Code Climate](https://codeclimate.com/github/mmi-cookbooks/metrics-repose/badges/gpa.svg)](https://codeclimate.com/github/mmi-cookbooks/metrics-repose)
[![Coverage Status](https://coveralls.io/repos/mmi-cookbooks/metrics-repose/badge.svg?branch=master&service=github)](https://coveralls.io/github/mmi-cookbooks/metrics-repose?branch=master)

# metrics-repose

This cookbook wraps the standard [repose cookbook](https://github.com/rackerlabs/cookbook-repose) and applies Rackspace Metrics particular settings and filters.

To use this cookbook you'll need to add it via [berkshelf](http://berkshelf.com/) or otherwise get it into your cookbooks dir.  You'll also need to reference the base repose cookbook.

## Supported Platforms

Other platforms are untested.

- Ubuntu 14.04

## Attributes

**TODO** Complete the table for a prize!

Key | Type | Description | Default
--- | --- | --- | ---
['foo'] | String | some description | 'bar'

## Usage

### metrics-repose::default

Include `metrics-repose` in your node's `run_list`:

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
