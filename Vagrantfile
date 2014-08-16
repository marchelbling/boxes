# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = 'ubuntu/trusty64'

  # Disable automatic box update checking
  config.vm.box_check_update = false

  config.ssh.forward_agent = true

  # VirtualBox generic configuration
  config.vm.provider 'virtualbox' do |vb|
    vb.customize ['modifyvm', :id, '--cpus', 2]
    vb.customize ['modifyvm', :id, '--memory', 2048]
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
  end

  # define boxes
  [['instapdf', '192.172.0.117']].each do |vm_name, vm_ip|
    primary = true

    config.vm.provider 'virtualbox' do |vb|
      vb.name = vm_name
    end

    config.vm.define vm_name, primary: primary, autostart: primary do |vm_config|
      vm_name = vm_name + '.' + 'box'

      # set box config
      vm_config.vm.network :private_network, ip: vm_ip

      # set box name
      vm_config.vm.provider 'virtualbox' do |v|
        v.name = vm_name
      end

      # Enable provisioning with chef solo
      config.omnibus.chef_version = :latest
      # let librarian deal with cookbooks versions
      config.librarian_chef.cheffile_dir = './'

      config.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = ['cookbooks', 'site-cookbooks']
        chef.roles_path = 'roles'
        chef.data_bags_path = 'data_bags'
        chef.environments_path = 'environments'

        chef.json = {
          'run_list' => [
            "role[#{vm_name}]"
          ]
        }
      end
    end
  end
end
