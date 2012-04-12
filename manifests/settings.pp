# = Class: jenkins::settings::config
#
# Initializes and fixes the config file so augeas can parse it.
#
# See https://fedorahosted.org/augeas/ticket/258 for more information.
#
class jenkins::settings {

  require jenkins::params
  $config = $jenkins::params::config_file
  $user   = $jenkins::params::user
  $group  = $jenkins::params::group

  $need_fix = true
#  $need_fix = versioncmp($::augeasversion, '0.11.0')

  if $need_fix {
    $fix_command = template('jenkins/settings/fix_augeas.cmd')
    $refix_command = template('jenkins/settings/fix_jenkins.cmd')

    exec {'jenkins_settings_config_fix_config':
      command => "${fix_command} ${config}",
      onlyif  => "[ -f ${config} ] && head -n 1 ${config} | grep -q \"'\"",
      path    => '/bin:/usr/bin',
    }

    exec {'jenkins_settings_config_refix_config':
      command => "${refix_command} ${config}",
      onlyif  => "[ -f ${config} ] && head -n 1 ${config} | grep -q '\"'",
      path    => '/bin:/usr/bin',
    }

    Exec['jenkins_settings_config_fix_config']
      -> Jenkins::Config<| |>
      -> Exec['jenkins_settings_config_refix_config']
      -> Service['jenkins']

  }

  file {$config:
    ensure  => present,
    content => template('jenkins/settings/config.xml.erb'),
    owner   => $user,
    group   => $group,
    replace => false,
    notify  => Service['jenkins'],
  }

}

