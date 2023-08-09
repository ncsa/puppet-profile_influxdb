# @summary Install and configure InfluxDB service
#
# Install and configure InfluxDB service
#
# @example
#   include profile_influxdb
class profile_influxdb {
  include profile_influxdb::backup
  include profile_influxdb::config
  include profile_influxdb::firewall
  include profile_influxdb::service
}
