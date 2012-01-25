class jenkins{

	include jenkins::package
	include jenkins::service
  ##	include jenkins::plugins

}


class jenkins::plugins{

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

