

#case node['platform']
#when 'debian', 'ubuntu'
#execute "apt-get update"
#when 'redhat', 'centos', 'fedora'
#execute "yum update -y"
#end

include_recipe "java"

jboss_user = node['jboss-eap']['jboss_user']
jboss_group = node['jboss-eap']['jboss_group']

# Create JBoss User
user jboss_user do
	action :create
end

package "unzip" do
  action :install
end


bash 'download jboss-eap' do
  code <<-EOH
wget #{node['jboss-eap']['package_url']} -P /tmp/
tar xvzf /tmp/wildfly*.tar.gz -C #{node['jboss-eap']['install_path']}
mv #{node['jboss-eap']['install_path']}/wildfly* #{node['jboss-eap']['install_path']}/jboss
chown -R #{jboss_user}:#{jboss_group} #{node['jboss-eap']['install_path']}/jboss
rm -rf /tmp/*.tar.gz
     EOH
end

template "/etc/init.d/jboss" do
  if platform? ["centos", "redhat"] 
    source "wildfly-init-redhat.sh.erb"
  else
    source "wildfly-init-debian.sh.erb"
  end
  mode "0755"
  owner "root"
  group "root"
end

# Init script config dir
directory node['jboss-eap']['config_dir'] do
	owner 'root'
	group 'root'
	mode "0755"
end

# Init script config file
template "#{node['jboss-eap']['config_dir']}/jboss-as.conf" do
  source    'jboss-as.conf.erb'
  owner 'root'
  group 'root'
  mode "0644"
end

# Manage log directory
default_log_dir = "#{node['jboss-eap']['jboss_home']}/standalone/log"

# Delete default log directory if it's not a symlink and not the same as the specified log_dir
directory default_log_dir do
	action :delete
	not_if { node['jboss-eap']['log_dir'] == default_log_dir }
	not_if "test -L #{default_log_dir}"
end

# Create log directory
directory node['jboss-eap']['log_dir'] do
	owner node['jboss-eap']['jboss_user']
	group node['jboss-eap']['jboss_group']
	mode "2775"
end

template "#{node['jboss-eap']['standalone_config']}" do
  source    'standalone.xml.erb'
  owner jboss_user
  group jboss_group
  mode "0755"
end


# Log directory symlink
link default_log_dir do
	to node['jboss-eap']['log_dir']
	owner node['jboss-eap']['jboss_user']
	group node['jboss-eap']['jboss_group']
	not_if { node['jboss-eap']['log_dir'] == default_log_dir }
end

# Enable service on boot if requested
service "jboss" do
	if node['jboss-eap']['start_on_boot']
		action [ :enable, :start ]
	else
		action [ :disable, :start ]
	end
end
