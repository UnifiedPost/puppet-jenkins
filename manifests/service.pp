# = Class: jenkins::service
#
# Setup the jenkins service.
#
class jenkins::service {

  service {'jenkins':
    ensure     => 'running',
    enable     => true,
    require    => Package['jenkins'],
    hasrestart => true,
    hasstatus  => true,
  }

}

