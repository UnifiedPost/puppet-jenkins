class jenkins {

  include jenkins::package
  include jenkins::service
  include jenkins::settings

}
