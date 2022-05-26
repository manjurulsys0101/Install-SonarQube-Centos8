dnf update -y --allowerasing --nobest
sudo dnf install config-manager --add-repo=https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo dnf groupinstall "Development Tools" -y
sudo dnf -y install rsync gcc zlib-devel libvirt-devel cmake
sudo dnf install -y ruby ruby-devel
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum install vagrant -y
vagrant --version
sudo mkdir -p /vagrant/Centos8/
echo '
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/8"
  config.vm.box_check_update = false
  config.vm.hostname = "centos8"
  #config.vm.network "public_network",
   # use_dhcp_assigned_default_route: true
  config.vm.network :public_network, ip: "192.168.1.213", netmask: "255.255.255.0"
  config.vm.network :forwarded_port, guest: 22, host: 2222, host_ip: "0.0.0.0", id: "ssh", auto_correct: true
  #config.vm.network :forwarded_port, guest: 22, host: 2022
  config.vm.provider "virtualbox" do |vb|
  # Display the VirtualBox GUI when booting the machine
     vb.gui = false
     vb.memory = "2048"
     vb.cpus = 2
  end
end' >> /vagrant/Centos8/Vagrantfile
cd /vagrant/Centos8/
vagrant up
