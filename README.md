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

## Kitchen and Travis
You can run 'kitchen test' or 'kitchen converge [ingest|query]' to test the cookbook.  This cookbook will run some lint checking on TravisCI when pushed to github.
