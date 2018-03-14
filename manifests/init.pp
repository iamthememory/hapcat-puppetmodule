# hapcat
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include hapcat
class hapcat(
  Enum['present', 'absent', 'purged', 'held', 'latest'] $package_ensure = 'latest',
  Boolean $package_manage = true,
  $package_pip_url = 'git+https://github.com/iamthememory/hapcat-backend.git',
  $package_virtualenv = 'system',

  $service_command = '/usr/bin/pip -m hapcat.apiserver',
  Boolean $service_enable = true,
  Stdlib::Ensure::Service $service_ensure = 'running',
  Stdlib::Absolutepath $service_file = '/etc/systemd/system/hapcat.service',
  $service_group = 'root',
  Boolean $service_manage = true,
  $service_name = 'hapcat',
  $service_user = 'root',
  Stdlib::Absolutepath $service_workingdirectory = '/var/lib/hapcat',
) {

  contain hapcat::install
  contain hapcat::config
  contain hapcat::service

  Class['::hapcat::install']
  -> Class['::hapcat::config']
  ~> Class['::hapcat::service']

}
