# == Class: jenkins::package
#
# Install the jenkins package
#
class jenkins::package {

  include jenkins::params
  $package  = $jenkins::params::package
  $java     = $jenkins::params::java

  if ! defined(Package[$java]) {
    package {$java:
      ensure => 'present',
    }
  }

  package {$package:
    ensure  => 'present',
    alias   => 'jenkins',
    require => Package[$java],
  }

}

