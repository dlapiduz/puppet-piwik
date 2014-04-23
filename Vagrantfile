# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "centos65"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path    = ["puppet/modules"]
    puppet.options        << '--hiera_config=/etc/puppet/hiera.yaml'
  end

  config.vm.define :piwik do |piwik_config|
    piwik_config.vm.hostname = "piwik.test"
    piwik_config.vm.network "forwarded_port", guest: 80, host: 8080
  end

  config.vm.synced_folder "puppet", "/etc/puppet"

  # Use Vagrant Cachier to cache guest packages (YUM, NPM, etc.) on the host
  # system for re-use on future Vagrant builds.  You will need to install the
  # Vagrant Cachier plugin with: `vagrant plugin install vagrant-cachier`
  # See: http://fgrehm.viewdocs.io/vagrant-cachier
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

end

