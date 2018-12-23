# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box = 'azure'

  # use local ssh key to connect to remote vagrant box
  config.ssh.private_key_path = '~/.ssh/id_rsa'
  
  config.vm.provider :azure do |azure, override|

    # each of the below values will default to use the env vars named as below if not specified explicitly
    azure.tenant_id = ENV['AZURE_TENANT_ID']
    azure.client_id = ENV['AZURE_CLIENT_ID']
    azure.client_secret = ENV['AZURE_CLIENT_SECRET']
	azure.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']

    azure.vm_image_urn = 'Canonical:UbuntuServer:16.04-LTS:16.04.201612210'
    azure.resource_group_name = 'ivgestiongroup'
    azure.location = 'westeurope'  
    # westeurope, North Europe'
    azure.vm_size = 'Standard_DS1_v2'
    azure.tcp_endpoints = '80'

  end

  config.vm.provision :ansible do |ansible|
      ansible.playbook = "provision/playbook.yml"
  end

end




