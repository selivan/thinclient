# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.7.0"

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  config.vm.define "thinclient-build" do |machine|
      machine.vm.network "private_network", ip: "192.168.10.1"

      machine.vm.provider "virtualbox" do |vb|
        # Display the VirtualBox GUI when booting the machine
        vb.gui = false
      end

      machine.vm.provision "shell", inline: <<-SHELL
        if [ ! -f /usr/bin/python ]; then
          apt-get update
          apt-get install -y python-minimal
        fi
      SHELL

  end

  config.vm.define "thinclient-template" do |machine|
      machine.vm.network "private_network", ip: "192.168.10.2"
  end

  config.vm.define "thinclient-test" do |machine|
      # Manual interface configuration
      machine.vm.network "private_network", ip: "192.168.10.3",
        auto_config: false
  end

  # config.vm.provider "virtualbox" do |vb|
  #   #
  #   vb.name = "thinclient-builder"
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = false
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "2048"
  #   #
  #   vb.cpus = 2
  # end
  #
  # # Ansible requires python2 on target host
  # config.vm.provision "shell", inline: <<-SHELL
  #   if [ ! -f /usr/bin/python ]; then
  #     apt-get update
  #     apt-get install -y python-minimal
  #   fi
  # SHELL
  #
  # config.vm.provision "ansible_local" do |ansible|
  #   ansible.install = true
  #   ansible.verbose = "v"
  #   ansible.playbook = "thinclient.yml"
  # end

end
