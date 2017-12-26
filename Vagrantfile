# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.7.0"

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  #config.vm.box_check_update = false

  # Machine to test images, boots from PXE
  config.vm.define "test" do |machine|
      # Manual interface configuration
      machine.vm.provider "virtualbox" do |vb|
        vb.customize [
            "modifyvm", :id,
            "--boot1", "net",
            "--boot2", "none",
            "--boot3", "none",
            "--boot4", "none",
            "--nic1", "intnet",
            "--intnet1", "thinclient-pxc"
        ]
      end
  end

  # Machine to be template for images
  # Provisioning is mostly  done later by "server" machine
  config.vm.define "template" do |machine|
      machine.vm.network "private_network", ip: "192.168.10.2", virtualbox__intnet: "thinclient-pxc"

      # Ansible requires python v2 installed
      machine.vm.provision "shell", inline: <<-SHELL
        if [ ! -f /usr/bin/python ]; then
          apt-get update
          apt-get install -y python-minimal
        fi
      SHELL

  end

  # Machine to be used as PXC server and to configure others with ansible
  config.vm.define "server" do |machine|
      machine.vm.network "private_network", ip: "192.168.10.1", virtualbox__intnet: "thinclient-pxc"

      machine.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 2
      end

      # Ansible requires python v2 installed
      machine.vm.provision "shell", inline: <<-SHELL
        if [ ! -f /usr/bin/python ]; then
          apt-get update
          apt-get install -y python-minimal
        fi
      SHELL

      # Provision for all machines
      machine.vm.provision "ansible_local" do |ansible|
        ansible.install = true
        ansible.limit = "all"
        ansible.raw_arguments = [ "--ssh-common-args=\"-o StrictHostKeyChecking=no -o ControlMaster=auto -o ControlPersist=60s -o UserKnownHostsFile=/dev/null -o IdentitiesOnly=yes\"" ]
        ansible.verbose = "v"
        ansible.playbook = "thinclient.yml"
        ansible.inventory_path = "thinclient.inventory.ini"
      end

  end

end
