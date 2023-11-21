# @summary Manage the InfluxDB configuration and files.
#
# Manage the InfluxDB configuration and files.
#
# @param data_dir
#   Directory where the TSM storage engine stores TSM files.
#
# @param data_index_version
#   Type of shard index to use for new shards.
#
# @param data_query_log_enabled
#   Whether queries should be logged before execution.
#
# @param data_series_id_set_cache_size
#   Size of internal cache used by TSI index to store calculated series results.
#
# @param data_wal_dir
#   Directory where the TSM storage engine stores WAL files.
#
# @param group
#   Group name for permissions of data directories.
#
# @param http_auth_enabled
#   Whether user authentication is enabled over HTTP/HTTPS.
#
# @param http_bind_address
#   Bind address used by the HTTP service.
#
# @param http_bind_port
#   Bind port used by the HTTP service.
#
# @param http_https_enabled
#   Whether HTTPS is enabled.
#
# @param http_https_certificate
#   SSL certificate file to use when HTTPS is enabled.
#
# @param http_https_private_key
#   SSL private key file to use when HTTPS is enabled.
#
# @param http_log_enabled
#   Whether HTTP request logging is enabled.
#
# @param http_max_body_size
#   Maximum size of a client request body, in bytes. Setting to 0 disables the limit.
#
# @param http_pprof_enabled
#   Whether pprof endpoint is enabled (used for troubleshooting and monitoring)
#
# @param host
#   Hostname of service. Defaults to host's FQDN. Parameter not currently used anywhere.
#
# @param logging_level
#   Level of logs emitted. The available levels are error, warn, info, and debug.
#
# @param meta_dir
#   Directory where the metadata/raft database is stored.
#
# @param monitor_store_interval
#   Interval at which to record statistics.
#
# @param reporting_disabled
#   Whether to disable reporting of usage data to usage.influxdata.com.
#
# @param ssl_ca_content
#   Content of the SSL CA certificate(s) issued by the CA which signed the certificate.
#
# @param ssl_cert_content
#   Content of the SSL certificate to be used by the influxdb service.
#
# @param ssl_key_content
#   Content of the SSL private key used in the CSR for the certificate.
#
# @param tls_ciphers
#   Available set of cipher suites.
#
# @param tls_max_version
#   Maximum version of the tls protocol that will be negotiated.
#
# @param tls_min_version
#   Minimum version of the tls protocol that will be negotiated.
#
# @param user
#   User name for permissions of data directories.
#
# @example
#   include profile_influxdb::config
class profile_influxdb::config (
  String        $data_dir,
  String        $data_index_version,
  Boolean       $data_query_log_enabled,
  Integer       $data_series_id_set_cache_size,
  String        $data_wal_dir,
  String        $group,
  Boolean       $http_auth_enabled,
  String        $http_bind_address,
  Integer       $http_bind_port,
  Boolean       $http_https_enabled,
  String        $http_https_certificate,
  String        $http_https_private_key,
  Boolean       $http_log_enabled,
  Integer       $http_max_body_size,
  Boolean       $http_pprof_enabled,
  String        $host,
  String        $logging_level,
  String        $meta_dir,
  String        $monitor_store_interval,
  Boolean       $reporting_disabled,
  String        $ssl_ca_content,
  String        $ssl_cert_content,
  String        $ssl_key_content,
  Array[String] $tls_ciphers,
  String        $tls_max_version,
  String        $tls_min_version,
  String        $user,
) {
  # ENSURE FILES
  $file_defaults = {
    owner  => 'root',
    group  => 'root',
    ensure => file,
    mode   => '0644',
  }

  $managed_by_puppet = '# This file is managed by Puppet - Changes will be overwritten'

  file {
    '/etc/influxdb/influxdb.conf':
      content => template('profile_influxdb/influxdb.conf.erb'),
      ;
    $http_https_certificate:
      content => Sensitive( "${managed_by_puppet}\n${ssl_cert_content}\n${ssl_ca_content}" ),
      ;
    $http_https_private_key:
      content => Sensitive( "${managed_by_puppet}\n${ssl_key_content}" ),
      group   => $group,
      mode    => '0640',
      ;
    default:
      * => $file_defaults
      ;
  }

  # ENSURE DIRECTORIES
  $directory_defaults = {
    ensure  => directory,
    mode    => '0644',
    owner   => $user,
    group   => $group,
  }

  file {
    $data_dir:
      ;
    $data_wal_dir:
      ;
    $meta_dir:
      ;
    default:
      * => $directory_defaults
      ;
  }
}
