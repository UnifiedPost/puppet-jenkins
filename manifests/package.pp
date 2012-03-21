# == Class: jenkins::package
#
# Install the jenkins package
#
class jenkins::package {

  include jenkins::params
  $package        = $jenkins::params::package
  $package_ensure = $jenkins::params::package_ensure
  $java           = $jenkins::params::java

  if ! defined(Package[$java]) {
    package {$java:
      ensure => 'present',
    }
  }

  package {$package:
    ensure  => $package_ensure,
    alias   => 'jenkins',
    require => Package[$java],
  }

}

