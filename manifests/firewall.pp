# @summary Open InfluxDB port in the firewall
#
# @param allowed_subnets
#   Subnets allowed access via InfluxDB ports
#
# @example
#   include profile_influxdb::firewall
class profile_influxdb::firewall (
  Hash[String,String] $allowed_subnets,
) {
  $allowed_subnets.each | $location, $source_cidr | {
    firewall { "400 allow InfluxDB HTTP on tcp port ${profile_influxdb::config::http_bind_port} from ${location}":
      dport  => $profile_influxdb::config::http_bind_port,
      proto  => tcp,
      source => $source_cidr,
      action => accept,
    }
  }
}
