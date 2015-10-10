Vagrant.configure("2") do |config|

#-----------------------------------Virtualbox Centos---------------
config.vm.define "centos_box" do |d2|
    d2.vm.provider "virtualbox" do |v|
      v.name = "devops"
      v.memory = 2048
      v.cpus = 2
      v.gui = true
    end
    d2.vm.network "private_network", type: "dhcp"
    d2.vm.box =  'centos-6.6'
    d2.vm.box_url = 'https://github.com/tommy-muehle/puppet-vagrant-boxes/releases/download/1.0.0/centos-6.6-x86_64.box'
   #d2.vm.synced_folder ".", "/vagrant", type: "rsync", group: "www-data", owner: "www-data", mount_options: ["dmode=775,fmode=664"]
    set_solo(d2)
end
#-----------------------------------Virtualbox Ubuntu---------------
config.vm.define "ubuntu_box" do |d3|
    d3.vm.provider "virtualbox" do |v|
      v.name = "devops2"
      v.memory = 2048
      v.cpus = 2
      v.gui = true
    end
    d3.vm.network "private_network", type: "dhcp"
    d3.vm.box = "ubuntu/trusty64"
   #d3.vm.synced_folder ".", "/vagrant", type: "rsync", group: "www-data", owner: "www-data", mount_options: ["dmode=775,fmode=664"]
    set_solo(d3)
end
#------------------------------------Docker-------------------

#------------------------------------Vsphere-----------------

#-------------------------------------AmazonEC2--------------

#-------------------------------------Chef-client------------
def set_provision (config)
    config.vm.provision "chef_client" do |chef|
      chef.chef_server_url = "https://chef.oxagile.com"
      chef.validation_key_path = "./validation.pem"
      chef.add_role "java"
    end   
end

def set_solo (config)
    config.vm.provision "chef_solo" do |chef|
      chef.environments_path = "environments"
      chef.cookbooks_path = ["cookbooks"]
      chef.roles_path = "roles"
      chef.data_bags_path = "data_bags"
      chef.json.merge!(JSON.parse(Pathname(__FILE__).dirname.join('nodes', 'vagrant.json').read))
    end 
end

end