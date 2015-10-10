
include_recipe "jboss-dev-cookbook"

jboss_user = node['jboss-eap']['jboss_user']
jboss_group = node['jboss-eap']['jboss_group']

# Fetch the tarball if it's not a local file 
remote_file '/tmp/testweb.zip' do 
	source "#{node['jboss-eap']['deploy_url']}"
end

bash 'deploy app' do
  code <<-EOH
unzip /tmp/testweb.zip -d #{node['jboss-eap']['deploy_dir']}
chown -R #{jboss_user}:#{jboss_group} #{node['jboss-eap']['install_path']}/jboss
rm -rf /tmp/testweb*
     EOH
end

service "jboss" do
		action :restart
end
