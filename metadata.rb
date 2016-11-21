name 'metrics-repose'
maintainer 'Rackspace Metrics'
maintainer_email 'sfo-devops@lists.rackspace.com'
license 'Apache 2.0'
description 'Installs/Configures metrics-repose'
long_description 'Installs/Configures repose and Rackspace Metrics configuration for repose'
version '0.1.17'

if respond_to?(:source_url)
  source_url 'https://github.com/mmi-cookbooks/metrics-repose'
end
if respond_to?(:issues_url)
  issues_url 'https://github.com/mmi-cookbooks/metrics-repose/issues'
end

depends 'apt'
depends 'java'
depends 'repose'
