# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.network :private_network, ip: "111.111.111.111"

  config.vm.box = "phusion/ubuntu-14.04-amd64"

  config.ssh.forward_agent = true

  config.vm.synced_folder "www", "/var/www"

  config.vm.provision "ansible" do |ansible|

    ansible.inventory_path = "ci/vagrant"
    ansible.sudo = true
    ansible.playbook = "ci/master.yml"
    ansible.limit = "all"
    end

  end
