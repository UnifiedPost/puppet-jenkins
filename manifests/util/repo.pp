# = Class: jenkins::util::repo
#
# Installs the jenkins repository.
#
# == Notes:
#
# Based on https://github.com/rtyler/puppet-jenkins/
#
class jenkins::util::repo {

  #  anchor { 'jenkins::util::repo::alpha': }
  #  anchor { 'jenkins::util::repo::omega': }
  case $::operatingsystem {
    centos, redhat, oel: {
      include jenkins::util::repo::el
      # class { 'jenkins::util::repo::el':
      #   require => Anchor['jenkins::util::repo::alpha'],
      #   before  => Anchor['jenkins::util::repo::omega'],
      # }
    }
    debian,ubuntu: {
      include jenkins::util::repo::debian
      # class { 'jenkins::util::repo::debian':
      #  require => Anchor['jenkins::util::repo::alpha'],
      #  before  => Anchor['jenkins::util::repo::omega'],
      # }
    }
    default: {
      notify {'jenkins-util-repo-unsupported':
        message => "jenkins::util::repo does not support your operatingsystem: ${::operatingsystem}.",
      }
    }
  }
}

