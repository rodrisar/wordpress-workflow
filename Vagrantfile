# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  environments_json_path = "environments.json"
  vagrant_config = (JSON.parse(File.read(environments_json_path)))['vagrant']
  api_config = (JSON.parse(File.read(environments_json_path)))['api']

  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  #provisioning
  config.vm.provision "shell", path: "wordpress-workflow/provision/preprovision.sh"
  config.vm.provision "file", source:"wordpress-workflow/provision/templates/", destination: "/home/vagrant/templates/"
  config.vm.provision "file", source:"wordpress-workflow/provision/", destination: "/home/vagrant/provision/"
  config.vm.provision "shell", path: "wordpress-workflow/provision/provision.sh"

  #Dinamyc domains
  ## Default site folder
  config.vm.provision "file", source:"src/site/", destination: vagrant_config['public_dir']

  ## Creates each vhost (site, api) dynamically
  config.vm.provision "shell" do |s|
    s.path="wordpress-workflow/provision/vhosts.sh"
    s.args = [vagrant_config['url'], vagrant_config['public_dir'], api_config['url'], api_config['public_dir']]
  end

  # Creates vhosts for wordpress-workflow
  config.vm.provision "shell", path: "wordpress-workflow/provision/postprovision.sh"

  # Private IP
  config.vm.network :private_network, ip: "192.168.33.77"

  # Hosts
  config.vm.hostname = "www.wordpress-workflow.local"
  config.hostsupdater.aliases = ["wordpress-workflow.local", vagrant_config['url'], api_config['url']]

  # Shared folders.
  config.vm.synced_folder "src", "/home/vagrant/wordpress-workflow"
  config.vm.synced_folder "wordpress-workflow/documentation", "/home/vagrant/workflow-documentation"

  # Provider
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end

end
