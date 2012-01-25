# = Class: jenkins::disabled
#
# Description of jenkins::disabled
#
# == Parameters:
#
class jenkins::disabled inherits jenkins::service {

  require jenkins::package

  Service['jenkins'] {
    ensure  => 'stopped',
    enable  => false,
    require => Package['jenkins'],
  }

}

