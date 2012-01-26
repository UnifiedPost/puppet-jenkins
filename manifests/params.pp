# == Class: jenkins::params
#
# Description of jenkins::params
#
# === Parameters:
#
# === Actions:
#
# === Requires:
#
# === Sample Usage:
#
class jenkins::params(
  $java_package = undef,
) {

  $package = 'jenkins'
  case $java_package {
    undef: {
      case $::operatingsystem {
        /(?i:centos|redhat)/: { $java = 'java-1.6.0-openjdk' }
        /(?i:debian|ubuntu)/: { $java = 'openjdk-6-jdk' }
        default: {
          fail("The jenkins module has no java dependency configured for your operatingsystem: ${::operatingsystem}")
        }
      }
    }
    default: {
      $java = $java_package
    }
  }

}

