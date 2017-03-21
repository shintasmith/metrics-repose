# encoding: UTF-8
# License:: Apache License, Version 2.0
#

require_relative 'spec_helper'

describe file('/etc/sysconfig/repose') do
  it { should be_file }
  it { should be_mode 644 }
end

describe file('/etc/repose/slf4j-http-logging.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
  its(:content) do
    should match(/{"received": "%t", "duration": "%T", "method": "%m", "url": "%U", "status": "%s", "remote_ip": "%a", "local_ip": "%A", "server_port": "%p", "request.accept": "%{accept}i", "request.accept-encoding": "%{accept-encoding}i", "request.Connection": "%{Connection}i", "request.Content-Encoding": "%{Content-Encoding}i", "request.Content-Length": "%{Content-Length}i", "request.Content-Type": "%{Content-Type}i", "request.Method": "%{method}i", "request.Host": "%{Host}i", "request.query_string": "%q", "request.Received": "%{Received}i", "request.SSLClientCertStatus": "%{SSLClientCertStatus}i", "request.SSLClientCipher": "%{SSLClientCipher}i", "request.SSLSessionID": "%{SSLSessionID}i", "request.trans-id": "%{trans-id}i", "request.URL": "%U", "request.User-Agent": "%{user-agent}i", "request.X-Cluster-Client-Ip": "%{X-Cluster-Client-Ip}i", "request.X-Forwarded-For": "%{X-Forwarded-For}i", "request.X-Forwarded-Port": "%{X-Forwarded-Port}i", "request.X-Forwarded-Proto": "%{X-Forwarded-Proto}i", "request.via": "%{via}i", "request.x-authorization": "%{x-authorization}i", "request.x-default-region": "%{x-default-region}i", "request.x-pp-groups": "%{x-pp-groups}i", "request.x-pp-user": "%{x-pp-user}i", "request.x-real-ip": "%{x-real-ip}i", "request.x-roles": "%{x-roles}i", "request.x-tenant-id": "%{x-tenant-id}i", "request.x-tenant-name": "%{x-tenant-name}i", "request.x-user-id": "%{x-user-id}i", "request.x-user-name": "%{x-user-name}i", "response.Content-Length": "%{content-length}o", "response.Content-Type": "%{content-type}o", "response.Date": "%{date}o", "response.server": "%{server}o"}/)
  end
end

describe file('/etc/repose/header-normalization.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
  its(:content) do
    should match %r{<blacklist id="authorization">
        		<header id="X-Authorization"/>
        		<header id="X-Token-Expires"/>
        		<header id="X-Identity-Status"/>
        		<header id="X-Impersonator-Id"/>
        		<header id="X-Impersonator-Name"/>
        		<header id="X-Impersonator-Roles"/>
        		<header id="X-Roles"/>
        		<header id="X-Contact-Id"/>
        		<header id="X-Device-Id"/>
        		<header id="X-User-Id"/>
        		<header id="X-User-Name"/>
        		<header id="X-PP-User"/>
        		<header id="X-PP-Groups"/>
        		<header id="X-Catalog"/>
        		<header id="X-Subject-Token"/>
        		<header id="X-Subject-Name"/>
        		<header id="X-Subject-ID"/>
		</blacklist>}
  end
end

describe file('/etc/repose/add-header.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
  its(:content) do
    should match %r{  <!-- This section is for headers to add in the request -->
    <request>
      <header
        name="content-type"
        quality="1"
        overwrite="false"
        >application/json</header>
    </request>

  <!-- This section is for headers to add in the response -->
    <response>
      <header
        name="content-type"
        quality="1"
        overwrite="false"
        >application/json</header>
    </response>
}
  end
end

describe file('/etc/repose/keystone-v2.cfg.xml') do
  it { should be_file }
  it { should be_mode 640 }
  its(:content) { should match %r{uri="https://identity.api.rackspacecloud.com"} }
end

describe file('/etc/repose/ip-identity.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
  its(:content) { should match(/<white-list quality="1.0">/) }
end

describe file('/etc/repose/rate-limiting.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
  its(:content) { should match %r{request-endpoint uri-regex="/v\[0-9.\]\+/\(hybrid:\)\?\[0-9\]\+/limits/\?" include-absolute-limits="true"/>} }
end

describe file('/etc/repose/validator.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
  its(:content) do
    should match %r{   <validator
      role="default"
      default="true"
      wadl="blueflood-ingest.wadl"
      dot-output="/tmp/blueflood-ingest.wadl.dot"
      enable-rax-roles="true"
      check-well-formed="false"
      check-grammars="true"
      check-elements="true"
      check-plain-params="true"
      do-xsd-grammar-transform="true"
      enable-pre-process-extension="true"
      remove-dups="true"
      xpath-version="2"
      xsl-engine="XalanC"
      join-xpath-checks="false"
    />}
  end
end

describe file('/etc/repose/container.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
end

describe file('/etc/repose/system-model.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
  its(:content) do
    should match %r{
            <filter name="slf4j-http-logging" />
            <filter name="header-normalization" />
            <filter name="add-header" />
            <filter name="keystone-v2" />
            <filter name="ip-identity" />
            <filter name="rate-limiting" />
            <filter name="api-validator" />
     }
  end
end

describe file('/etc/repose/container.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
  its(:content) { should match(/<deployment-config content-body-read-limit="1048576" connection-timeout="30000" read-timeout="30000" client-request-logging="true" >/) }
end

describe file('/etc/repose/dist-datastore.cfg.xml') do
  it { should be_file }
  it { should be_mode 644 }
  its(:content) { should match %r{<port port="9002" cluster="blueflood-ingest"/>} }
end

describe file('/etc/repose/log4j2.xml') do
  it { should be_file }
  it { should be_mode 644 }
  its(:content) { should match(/-repose-http-log\" level\=\"info\" additivity\=\"false\"\>/) }
end

describe service('repose-valve') do
  it { should be_enabled }
end
describe service('repose') do
  it { should be_running }
end
