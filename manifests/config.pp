# = Definition: jenkins::config
#
# Description of jenkins::config
#
# == Parameters:
#
# $changes::  Array of augeas settings to execute.
#
# == Actions:
#
# == Requires:
#
# == Sample Usage:
#
define jenkins::config (
  $changes
){

  require jenkins::params
  $config = $jenkins::params::config_file

  augeas {"jenkins_settings_config_${name}":
    incl    => $config,
    lens    => 'Xml.lns',
    context => "/files${config}",
    changes => $changes,
    notify  => Service['jenkins'],
    require => File[$config],
  }

}

