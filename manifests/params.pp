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
  $java_package             = undef,
  $runas_user               = undef,
  $runas_group              = undef,
  $override_core_plugins    = false,
  $package_ensure           = 'present',
  $config                   = undef,
  $config_home              = '/var/lib/jenkins',
  $config_java_cmd          = '',
  $config_java_options      = '-Djava.awt.headless=true',
  $config_port              = 8080,
  $config_ajb_port          = 8009,
  $config_debug_level       = 5,
  $config_access_log        = false,
  $config_handler_max       = 100,
  $config_handler_idle      = 20,
  $config_args              = ''
) {

  $package = 'jenkins'


  case $::operatingsystem {
    /(?i:centos|redhat)/: { }
    /(?i:debian|ubuntu)/: { }
    default: {
      fail("The jenkins module does not support your operatingsystem: ${::operatingsystem}")
    }
  }

  $java = $java_package ? {
    undef => $::operatingsystem ? {
      /(?i:centos|redhat)/ => 'java-1.6.0-openjdk',
      /(?i:debian|ubuntu)/ => 'openjdk-6-jdk',
      default              => undef,
    },
    default => $java_package,
  }

  $user = $runas_user ? {
    undef   => $::operatingsystem ? {
      /(?i:centos|redhat)/  => 'jenkins',
      /(?i:debian|ubuntu)/  => 'jenkins',
      default               => 'jenkins',
    },
    default => $runas_user,
  }

  $group = $runas_group ? {
    undef   => $::operatingsystem ? {
      /(?i:centos|redhat)/  => 'jenkins',
      /(?i:debian|ubuntu)/  => 'nogroup',
      default               => 'jenkins',
    },
    default => $runas_group,
  }

  $config_file = $config ? {
    undef   => $::operatingsystem ? {
      /(?i:centos|redhat)/  => '/etc/sysconfig/jenkins',
      /(?i:debian|ubuntu)/  => '/etc/default/jenkins',
      default               => undef,
    },
    default => $config,
  }




  $core_plugins = [
    'ant', 'cvs','javadoc','maven-plugin',
    'ssh-slaves','subversion', 'translation',
  ]

}

