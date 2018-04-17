# hapcat::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include hapcat::config
class hapcat::config {

  file { $hapcat::service_workingdirectory :
    ensure => directory,
    owner  => $hapcat::service_user,
    group  => $hapcat::service_group,
    mode   => '0750',
  }

}
