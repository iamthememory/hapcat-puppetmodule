# hapcat::install
#
# Install the Hapcat scripts and modules.
#
# @summary A short summary of the purpose of this class
#
# @example
#   include hapcat::install
class hapcat::install {

  if $hapcat::package_manage {

    if $hapcat::package_ensure != 'absent' {
      class { 'python' :
        pip    => 'present',
        ensure => 'present',
      }

      python::pip { 'psycopg2' :
        ensure       => 'present',
        pkgname      => 'psycopg2-binary',
        install_args => $hapcat::package_pip_install_args,
        virtualenv   => $hapcat::package_virtualenv,
      }

      python::pip { 'uwsgi' :
        ensure       => 'present',
        install_args => $hapcat::package_pip_install_args,
        virtualenv   => $hapcat::package_virtualenv,
      }

      case $::operatingsystem {
        'debian', 'ubuntu' : {
          $nologin = '/usr/sbin/nologin'
        }
        default: {
          $nologin = '/sbin/nologin'
        }
      }

      group { $hapcat::service_group :
        ensure => 'present',
        system => true,
      }
      -> user { $hapcat::service_user :
        ensure   => 'present',
        comment  => 'Hapcat service user',
        gid      => $hapcat::service_group,
        home     => $hapcat::service_workingdirectory,
        shell    => $nologin,
        system   => true,
        password => '!',
      }
    }

    python::pip { 'hapcat' :
      ensure       => $hapcat::package_ensure,
      pkgname      => 'hapcat',
      install_args => $hapcat::package_pip_install_args,
      url          => $hapcat::package_pip_url,
      virtualenv   => $hapcat::package_virtualenv,
    }
  }
}
