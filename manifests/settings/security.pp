# = Class: jenkins::settings::security
#
# Description of jenkins::settings::security
#
class jenkins::settings::security (
  $enable        = true,
  $securityrealm = 'hudson.security.SecurityRealm$None'
) {

  jenkins::config {'security':
    changes => [
      "set hudson/useSecurity/#text ${enable}",
    ],
  }
  jenkins::config{'security-realm':
    changes => [
      "set hudson/securityRealm/#attribute/class '${securityrealm}'",
    ]
  }
}

