# = Definition: jenkins::plugin
#
# Install a jenkins module with ease.
#
# == Parameters:
#
# $ensure::     Ensure wether a plugin should be present or absent.
#               Defaults to 'present'.
#
# $no_package:: Don't attempt to install the package. This can be used
#               to extend a core plugin with some puppet magic.
#               Defaults to true for core plugins, false for others.
#
define jenkins::plugin (
  $ensure = 'present',
  $no_package = undef
) {

  ## jenkins::params we will be using
  require jenkins::params
  $allow_override = $::jenkins::params::override_core_plugins
  $core_plugins = $::jenkins::params::core_plugins

  if $no_package == undef {
    if $name in $core_plugins {
      $nopackage = true
    } else {
      $nopackage = false
    }
  } else {
    $nopackage = $no_package
  }

  if ! $nopackage {
    if ! $allow_override and ($name in $core_plugins) {
      fail("jenkins::plugin on ${::hostname}: You are attempting to override a core plugin (${name}) and this has been disabled in jenkins::params!")
    }
    else {
      package {"jenkins-plugin-${name}":
        ensure  => $ensure,
        require => Package['jenkins'],
      }
    }
  }

  if defined("jenkins::plugin::${name}") {
    require "jenkins::plugin::${name}"
  }

}

