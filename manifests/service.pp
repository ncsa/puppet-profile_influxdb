# @summary Install InfluxDB package and manage service
#
# Install InfluxDB package and manage service
#
# @param manage_service
#   Flag of whether to manage InfluxDB service
#
# @param required_packages
#   List of package names to be installed (OS specific).
#
# @param service_name
#   Name of InfluxDB service
#
# @example
#   include profile_influxdb::service
class profile_influxdb::service (
  Boolean       $manage_service,
  Array[String] $required_packages,
  String        $service_name,
) {
  # PACKAGES
  ensure_packages( $required_packages, { 'ensure' => 'present' })

  if ( $manage_service ) {
    service { $service_name :
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
      require    => [
        Package[$required_packages],
        File['/etc/influxdb/influxdb.conf'],
      ],
      subscribe  => [
        File['/etc/influxdb/influxdb.conf'],
        File[$profile_influxdb::config::http_https_certificate],
        File[$profile_influxdb::config::http_https_private_key],
      ],
    }
  }
}
