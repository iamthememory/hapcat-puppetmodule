# hapcat
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include hapcat
class hapcat(
  $package_ensure = 'latest',
  Boolean $package_manage = true,
  $package_pip_url = 'git+https://github.com/iamthememory/hapcat-backend.git',
  $package_virtualenv = 'system',
  $package_pip_install_args = '',
  Stdlib::Absolutepath $package_config_file = '/etc/hapcatd.conf',

  $service_command = '/usr/local/bin/hapcatd',
  Boolean $service_enable = true,
  Stdlib::Ensure::Service $service_ensure = 'running',
  Stdlib::Absolutepath $service_file = '/etc/systemd/system/hapcat.service',
  $service_group = 'hapcat',
  Boolean $service_manage = true,
  $service_name = 'hapcat',
  $service_user = 'hapcat',
  Stdlib::Absolutepath $service_workingdirectory = '/var/lib/hapcat',

  Stdlib::Host $api_address = '0.0.0.0',
  Stdlib::Port $api_port = 8080,
  $database_url = "sqlite:////${hapcat::service_workingdirectory}/hapcatdb.sqlite3",
  Boolean $database_loadtestdata = false,
) {

  contain hapcat::install
  contain hapcat::config
  contain hapcat::service

  Class['::hapcat::install']
  -> Class['::hapcat::config']
  ~> Class['::hapcat::service']

  Class['::hapcat::install']
  ~> Class['::hapcat::service']
}
