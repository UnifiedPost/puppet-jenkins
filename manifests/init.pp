
class jenkins::enabled  {
 service{"jenkins":
        ensure => "running" ,
        enable => "true",
    }
}

# EOC jenkins::enabled 
class jenkins::disabled {
 service {"jenkins":
        ensure => "stopped" ,
        enable => "false",
    }

}
# EOC jenkins::disabled 


class jenkins::repo {

	yumrepo {
   	"jenkins":
            descr       => "jenkins",
            enabled     => 1,
            gpgcheck    => 0,
            baseurl     => "http://pkg.jenkins-ci.org/redhat/"; 
        

	}


}

class jenkins::package {
	package {
		"jenkins":
		     ensure => present;
	}



}

class jenkins{

	include jenkins::repo
	include jenkins::package
	Class["jenkins::repo"] -> Class["jenkins::package"]
	include jenkins::enabled 
	include jenkins::plugins 

}


class jenkins::plugins{

	  yumrepo { "inuits-jenkins-plugins":
            descr       => "inuits-jenkins-plugins",
            enabled     => 1,
            gpgcheck    => 0,
            baseurl     => "http://repo.inuits.be/jenkins/os";

        }


	package {
		"jenkins-analysis-core-plugin":
		     ensure => present;
		"jenkins-checkstyle-plugin":
		     ensure => present;
		"jenkins-clover-plugin":
		     ensure => present;
		"jenkins-doxygen-plugin":
		     ensure => present;
		"jenkins-dry-plugin":
		     ensure => present;
		"jenkins-git-plugin":
		     ensure => present;
		"jenkins-htmlpublisher-plugin":
		     ensure => present;
		"jenkins-jdepend-plugin":
		     ensure => present;
		"jenkins-plot-plugin":
		     ensure => present;
		"jenkins-pmd-plugin":
		     ensure => present;
		"jenkins-promoted-builds-plugin":
		     ensure => present;
		"jenkins-publish-over-ssh-plugin":
		     ensure => present;
		"jenkins-violations-plugin":
		     ensure => present;
		"jenkins-xunit-plugin":
		     ensure => present;

	}


}	

