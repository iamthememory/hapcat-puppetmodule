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

  file { $hapcat::package_config_file :
    ensure  => file,
    owner   => 'root',
    group   => $hapcat::service_group,
    mode    => '0440',
    content => epp('hapcat/hapcatd.conf.epp', {
      'api_address'           => $hapcat::api_address,
      'api_port'              => $hapcat::api_port,
      'database_url'          => $hapcat::database_url,
      'database_loadtestdata' => $hapcat::database_loadtestdata,
    }),
  }

}
