# hapcat::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include hapcat::service
class hapcat::service {

  if $hapcat::service_manage {

    include systemd

    if ! ($facts['systemd']) {
      fail('hapcat only supports systemd systems currently')
    }

    if ! ($hapcat::service_ensure in [ 'running', 'stopped' ]) {
      fail('service_ensure parameter must be running or stopped')
    }

    file { $hapcat::service_file :
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      notify  => Class['systemd::systemctl::daemon_reload'],
      content => epp('hapcat/hapcat.service.epp', {
        'service_user'             => $hapcat::service_user,
        'service_group'            => $hapcat::service_group,
        'service_workingdirectory' => $hapcat::service_workingdirectory,
        'uwsgi_command'            => $hapcat::uwsgi_command,
        'service_configfile'       => $hapcat::package_config_file,
      }),
    }

    file { $hapcat::socket_service_file :
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      notify  => Class['systemd::systemctl::daemon_reload'],
      content => epp('hapcat/hapcat.socket.epp', {
        'service_user'   => $hapcat::service_user,
        'service_group'  => $hapcat::service_group,
        'service_socket' => $hapcat::service_socket,
      }),
    }

    service { 'hapcat':
      ensure    => $hapcat::service_ensure,
      enable    => $hapcat::service_enable,
      name      => $hapcat::service_name,
      subscribe => File[$hapcat::service_file],
    }

    service { 'hapcat.socket':
      ensure    => $hapcat::service_ensure,
      enable    => $hapcat::service_enable,
      name      => $hapcat::socket_service_name,
      subscribe => File[$hapcat::socket_service_file],
    }

  }

}
