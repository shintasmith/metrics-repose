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
