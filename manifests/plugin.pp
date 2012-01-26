# = Definition: jenkins::plugin
#
# Install a jenkins module with ease.
#
# == Parameters:
#
# $ensure::     Ensure wether a plugin should be present or absent.
#               Defaults to 'present'.
#
define jenkins::plugin(
  $ensure = 'present'
) {

  package {"jenkins-plugin-${name}":
    ensure  => $ensure,
    require => Package['jenkins'],
  }

}

