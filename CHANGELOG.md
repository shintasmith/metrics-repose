# 0.1.17
- Adding pre-stop and post-start upstart blocks
	
# 0.1.16
- Add tenant handling to repose keystone_v2.cfg.xml to require tenant auth for query nodes and tenanted metrics.

# 0.1.15
- Fix rate limit values set incorrectly in 0.1.12

# 0.1.14
- Add missing crucial line that actually enables add-header filter

# 0.1.13
- Add the add-header filter to inject Content-Type header if it's not present

# 0.1.12
- Tweak rate limit values in repose for ingest and query nodes.
- Set special ingest rate limit for maas-prod tenant, and special query rate limit for lbaas-prod tenant.

# 0.1.11
- Updating wadls to match the correct RBAC roles.  Enabling rax:roles for validation.

# 0.1.10 
- add perf02 to list of environments for repose data_bag credentials

# 0.1.9
- set additivity to false for blueflood-ingest and blueflood-query http logger, this should stop double logging into /var/log/repose/current.log of http logs

# 0.1.8
- Adding tenanted-url to the keystone-v2 filter

# 0.1.7
- Update default number of log files to keep for /var/log/repose/blueflood-<instance>.log, downsize to 6 so we don't cause disk space alerts

# 0.1.6
- Update upstart script to refer to default-java instead of specific version
- Update customer rate-limit defaults to 2000/MIN for ingest and query (was ingest 1000/MIN and query 1500/MIN)

# 0.1.5
- Add the overlimit_429_responsecode attribute (set to true) so that our rate-limiting filter returns 429 status codes when we rate-limit (and not 413)

# 0.1.4
- Adjust log4j2 appender and upstart script so that logs don't fill up disk

# 0.1.3
- Revert back to use the ip-identity filter until we can upgrade to Repose 8 and use ip-user (it doesn't read from X-Forwarded-For in repose 7 filter)
- Add a rate limit group for maas-prod to give them a very large ceiling.

# 0.1.2
- Update global limit for rate-limiting filter
- Fix incorrect attribute names for http_connection_pool and update values 

# 0.1.1
- Update the logging format to add in additional HTTP headers
- Include install recipe in query and ingest setup so that on initial installs, chef doesn't bail when /etc/repose isn't extant

# 0.1.0
- Initial release of metrics-repose
