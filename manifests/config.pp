# hapcat::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include hapcat::config
class hapcat::config {
  include systemd

  if ! ($facts['systemd']) {
    fail("hapcat only supports systemd systems currently")
  }

  file { $hapcat::service_file:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => epp('hapcat.service.epp', {
      'service_user'             => $hapcat::service_user,
      'service_group'            => $hapcat::service_group,
      'service_workingdirectory' => $hapcat::service_workingdirectory,
      'service_command'          => $hapcat::service_command,
    },
  }

  file { $hapcat::service_workingdirectory:
    ensure => directory,
    owner  => $hapcat::service_user,
    group  => $hapcat::service_group,
    mode   => '0750',
  }
}
