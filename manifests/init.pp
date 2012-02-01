class jenkins {

  include jenkins::package
  include jenkins::service

  $modulename = 'up-puppet-jenkins'
  $moduleversion = '0.1'

}
