Vagrant.configure(2) do |config|
  config.vm.box = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"
  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "deploy_kueue"
  end
end
