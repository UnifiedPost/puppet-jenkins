# = Class: jenkins::util::repo::el
#
# Description of jenkins::util::repo::el
#
# == Note:
#
# Based on https://github.com/rtyler/puppet-jenkins
#
class jenkins::util::repo::el {

  file { '/etc/yum.repos.d/jenkins.repo':
    ensure => present,
    source => 'puppet://modules/jenkins/util/repo/jenkins.yum.repo',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  exec { 'rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key':
    path   => '/bin:/usr/bin',
    unless => 'rpm -q gpg-pubkey-d50582e6-4a3feef6',
  }

}

