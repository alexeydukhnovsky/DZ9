# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "generic/centos8s"

  config.vm.provider "virtualbox" do |v|
    v.memory = 256
    v.cpus = 1
  end

  config.vm.define "dzsystemd" do |repo|
    config.vm.synced_folder ".", "/vagrant"
    repo.vm.hostname = "dzsystemd"
    repo.vm.provision "shell", path: "dzsystemd.sh"
  end
  
end
