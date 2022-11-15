# profile_influxdb

![pdk-validate](https://github.com/ncsa/puppet-profile_influxdb/workflows/pdk-validate/badge.svg)
![yamllint](https://github.com/ncsa/puppet-profile_influxdb/workflows/yamllint/badge.svg)

NCSA Common Puppet Profiles - configure InfluxDB service

This profile is intended to install and configure the InfluxDB v1.8 service.

## Usage

To install and configure:

```
  include profile_influxdb
```

## Configuration

If leaving `$http_https_enabled` (default), you must supply the SSL certificate, CA, and private key content, e.g.:
```yaml
profile_influxdb::config::ssl_ca_content: |
  -----BEGIN CERTIFICATE-----
  ...
  -----END CERTIFICATE-----
profile_influxdb::config::ssl_cert_content: |
  -----BEGIN CERTIFICATE-----
  ...
  -----END CERTIFICATE-----
profile_influxdb::config::ssl_key_content: |
  -----BEGIN PRIVATE KEY-----
  ...
  -----END PRIVATE KEY-----
```


## Dependencies
- [puppetlabs/firewall](https://forge.puppet.com/puppetlabs/firewall)
- [puppetlabs/stdlib](https://forge.puppet.com/modules/puppetlabs/stdlib)


## Reference

[REFERENCE.md](REFERENCE.md)
