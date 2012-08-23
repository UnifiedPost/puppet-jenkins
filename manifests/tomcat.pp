# = Class: jenkins::tomcat
#
# Setup the jenkins using tomcat.
#
class jenkins::tomcat (
    $jenkins_dir                = '/var/lib/jenkins',
    $tomcat_catalina_config_dir = '/etc/tomcat6/Catalina/localhost/',
    $tomcat_webapps_dir         = '/var/lib/tomcat6/webapps',
) {

  class{'jenkins::service::disabled':}

  file { "$tomcat_webapps_dir/jenkins.war":
    ensure  => link,
    target  => '/usr/lib/jenkins/jenkins.war',
    require => [ Class ['jenkins::package'],
      Class ['jenkins::service::disabled'], ],
  }

  file { $jenkins_dir:
    ensure  => directory,
    owner   => 'tomcat',
    group   => 'tomcat',
    require => Class ['jenkins::package'],
  }

  file { $tomcat_catalina_config_dir:
    ensure  => present,
    content => template('jenkins/jenkins.xml.erb'),
  }
}
