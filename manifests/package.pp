# == Class: jenkins::package
#
# Install the jenkins package
#
class jenkins::package (
  $package  = $jenkins::params::package,
  $ensure   = $jenkins::params::package_ensure,
  $java     = $jenkins::params::java
) inherits jenkins::params {


  if ! defined(Package[$java]) {
    package {$java:
      ensure => 'present',
    }
  }

  package {$package:
    ensure  => $ensure,
    alias   => 'jenkins',
    require => Package[$java],
  }

}

