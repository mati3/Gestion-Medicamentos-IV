# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
	config.vm.box = "azure"
	config.ssh.private_key_path = '~/.ssh/id_rsa'
	
	config.vm.provider :azure do |azure, override|

	azure.tenant_id = ENV['AZURE_TENANT_ID']
	azure.client_id = ENV['AZURE_CLIENT_ID']
	azure.client_secret = ENV['AZURE_CLIENT_SECRET']
	azure.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']

	azure.vm_image = 'b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-16_04-LTS-amd64-server-20181023-en-us-30GB'
	azure.resource_group_name = 'ivgestiongroup'
	azure.location = 'westeurope'
	azure.vm_size = 'Standard_DS1_v2'
	azure.tcp_endpoints = '80'

	end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  	config.vm.provision :ansible do |ansible|
	   ansible.playbook = "provision/playbook.yml"
	end

end
