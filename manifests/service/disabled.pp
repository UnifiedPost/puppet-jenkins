# = Class: jenkins::service::disabled
#
# Setup the jenkins service but make sure it is not running.
#
# == Parameters:
#
class jenkins::service::disabled inherits jenkins::service {

  require jenkins::package

  Service['jenkins'] {
    ensure  => 'stopped',
    enable  => false,
    require => Package['jenkins'],
  }

}

