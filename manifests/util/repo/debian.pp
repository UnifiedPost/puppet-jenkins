# = Class: jenkins::util::repo::debian
#
# Description of jenkins::util::repo::debian
#
# == Note:
#
# Based on https://github.com/rtyler/puppet-jenkins
#
# == Todo:
#
# TEST !!
#
class jenkins::util::repo::debian {

  file {'/etc/apt/sources.list.d' :
    ensure => directory,
  }

  file { '/etc/apt/sources.list.d/jenkins.list' :
    ensure => present,
    notify => [
      Exec['install-key'],
      Exec['refresh-apt'],
    ],
    require => File['/etc/apt/sources.list.d'],
    source  => 'puppet:///modules/jenkins/util/repo/jenkins.apt.list',
  }

  exec { 'refresh-apt' :
    refreshonly => true,
    path        => ['/usr/bin', '/usr/sbin'],
    command     => 'apt-get update',
    require     => [
      File['/etc/apt/sources.list.d/jenkins.list'],
      Exec['install-key'],
    ],
  }

  exec { 'install-key' :
    notify  => Exec['refresh-apt'],
    path    => '/bin:/usr/bin',
    require => File['/etc/apt/sources.list.d/jenkins.list'],
    unless  => 'apt-key list | grep "D50582E6"',
    command => 'wget -q http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key  -O - | apt-key add -',
  }

}

