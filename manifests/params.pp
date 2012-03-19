# == Class: jenkins::params
#
# Description of jenkins::params
#
# === Parameters:
#
# $java_package::           Override the java package jenkins will depend on.
#                           Defaults to openjdk for your distro.
#
# $runas_user::             Override the jenkins user. This should only be
#                           used if you have your own custom package or
#                           changed the user manually.
#                           Defaults to the distro default.
#
# $runas_group::            Override the group for the jenkins user. This
#                           should only be used when you have your own custom
#                           package or you changed it manually.
#                           Defaults to the distro default.
#
# $override_core_plugins::  Flag to indicate you want to be able to override
#                           plugins that are normally packed with core jenkins.
#                           Defaults to false.
#
# === Actions:
#
# === Requires:
#
# === Sample Usage:
#
class jenkins::params(
  $java_package = undef,
  $runas_user = undef,
  $runas_group = undef,
  $override_core_plugins = false
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

  $config_file = $::operatingsystem ? {
    /(?i:centos|redhat)/  => '/var/lib/jenkins/config.xml',
    /(?i:debian)/         => '/var/lib/jenkins/config.xml',
    default               => '/var/lib/jenkins/config.xml',
  }


  $user = $runas_user ? {
    undef   => $::operatingsystem ? {
      /(?i:centos|redhat)/  => 'jenkins',
      /(?i:debian)/         => 'jenkins',
      default               => 'jenkins',
    },
    default => $runas_user,
  }

  $group = $runas_group ? {
    undef   => $::operatingsystem ? {
      /(?i:centos|redhat)/  => 'jenkins',
      /(?i:debian)/         => 'nogroup',
      default               => 'jenkins',
    },
    default => $runas_group,
  }

  $core_plugins = [
    'ant', 'cvs','javadoc','maven-plugin','ssh-slaves','subversion', 'translation'
  ]

}

