About this Test project
-----

Vagrant +Chef jboss cookbook +test application (http://www.cumulogic.com/download/Apps/testweb.zip)

Tested platforms
-----
Ubuntu 14.04
Centos 6.6

Usage
-----

Simply run `vagrant up centos_box` or `vagrant up ubuntu_box` in root project directory.

Run application http://172.28.128.X:8080/testweb/ ( usualy x=3)

Change nodes-vagrant.json file (jboss-dev-cookbook::default) for deploying jboss applicatin only.

Change attributes for jboss-dev-cookbook
-----

* `default['jboss-eap']['install_path'] = '/opt'`
* `default['jboss-eap']['symlink'] = 'jboss'`
* `default['jboss-eap']['config_dir'] = '/etc/jboss-as'`
* `default['jboss-eap']['package_url'] = 'http://download.jboss.org/wildfly/8.2.0.Final/wildfly-8.2.0.Final.tar.gz'`
* `default['jboss-eap']['log_dir'] = '/var/log/jboss'`
* `default['jboss-eap']['jboss_user'] = 'jboss'`
* `default['jboss-eap']['jboss_group'] = 'jboss'`
* `default['jboss-eap']['start_on_boot'] = false`
* `default['jboss-eap']['bind_adress'] = '0.0.0.0'`
* `default['java']['jdk_version'] = '7'`

* `default['jboss-eap']['deploy_url'] = "http://www.cumulogic.com/download/Apps/testweb.zip"`

Requirements
-----

Vagrant 1.7.2+
Virtualbox 5.0.0+ 
