# = Class: jenkins::settings::ldap_auth
#
# Description of jenkins::settings::ldap_auth
#
# <securityRealm class="hudson.security.LDAPSecurityRealm">
#    <server>ldap://ldap.uat.dc01.uni</server>
#    <rootDN>dc=um,dc=unifiedpost,dc=com</rootDN>
#    <inhibitInferRootDN>false</inhibitInferRootDN>
#    <userSearchBase>ou=People</userSearchBase>
#    <userSearch>uid={0}</userSearch>
#    <groupSearchBase>ou=Group</groupSearchBase>
#  </securityRealm>
#
#
class jenkins::settings::ldap_auth (
  $server_url,
  $rootdn,
  $usersearchbase,
  $usersearch,
  $groupsearchbase
) inherits jenkins::settings::security {

  require jenkins::settings

  $securityrealm = 'hudson.security.LDAPSecurityRealm'


  Jenkins::Config['security'] {
    changes => [
      "set hudson/useSecurity/#text 'true'",
    ]
  }

  Jenkins::Config['security-realm'] {
    changes => [
      "set hudson/securityRealm/#attribute/class '${securityrealm}'",
      "set hudson/securityRealm/server/#text '${server_url}'",
      "set hudson/securityRealm/rootDN/#text '${rootdn}'",
      "set hudson/securityRealm/userSearchBase/#text '${usersearchbase}'",
      "set hudson/securityRealm/userSearch/#text '${usersearch}'",
      "set hudson/securityRealm/groupSearchBase/#text '${groupsearchbase}'",
      "set hudson/securityRealm/inhibitInferRootDN/#text 'false'",
    ]
  }

}

