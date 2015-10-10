default['jboss-eap']['install_path'] = '/opt'
default['jboss-eap']['symlink'] = 'jboss'
default['jboss-eap']['jboss_home'] = "#{node['jboss-eap']['install_path']}/#{node['jboss-eap']['symlink']}"
default['jboss-eap']['config_dir'] = '/etc/jboss-as'
default['jboss-eap']['package_url'] = 'http://download.jboss.org/wildfly/8.2.0.Final/wildfly-8.2.0.Final.tar.gz'
default['jboss-eap']['log_dir'] = '/var/log/jboss'
default['jboss-eap']['jboss_user'] = 'jboss'
default['jboss-eap']['jboss_group'] = 'jboss'
default['jboss-eap']['start_on_boot'] = false
default['jboss-eap']['bind_adress'] = '0.0.0.0'
default['jboss-eap']['standalone_config'] = "#{node['jboss-eap']['jboss_home']}/standalone/configuration/standalone.xml"
default['java']['jdk_version'] = '7'

default['jboss-eap']['deploy_dir'] = "#{node['jboss-eap']['jboss_home']}/standalone/deployments"
default['jboss-eap']['deploy_url'] = "http://www.cumulogic.com/download/Apps/testweb.zip"