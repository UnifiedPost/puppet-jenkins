# == Class: jenkins::package
#
# Install the jenkins package
#
class jenkins::package {

  include jenkins::params

  package {$::jenkins::params::package_name:
    ensure => present,
    alias  => 'jenkins',
  }

}

