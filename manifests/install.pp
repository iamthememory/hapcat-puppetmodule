# hapcat::install
#
# A description of what this class does
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
