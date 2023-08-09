# @summary Configure InfluxDB backups
#
# @param locations
#   files and directories that are to be backed up
#
# @example
#   include profile_influxdb::backup
class profile_influxdb::backup (
  Array[String]     $locations,
) {
  if ( lookup('profile_backup::client::enabled') ) {
    include profile_backup::client

    profile_backup::client::add_job { 'profile_influxdb':
      paths            => $locations,
    }
  }
}
