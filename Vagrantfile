# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# WPDistillery Vagrantfile using Scotch Box
# Check out https://box.scotch.io to learn more about Scotch Box
#
# File Version: 1.2.1

Vagrant.configure("2") do |config|

    config.ssh.username = "vagrant"
    config.ssh.password = "vagrant"
    config.vm.box = "scotch/box"
    config.vm.network "private_network", ip: "192.168.33.10"
    config.vm.hostname = "wpdistillery.vm"

    # Use vagrant-winnfsd if available https://github.com/flurinduerst/WPDistillery/issues/78
    if Vagrant.has_plugin? 'vagrant-winnfsd'
      config.vm.synced_folder ".", "/var/www",
        nfs: true,
        mount_options: [
        'nfsvers=3',
        'vers=3',
        'actimeo=1',
        'rsize=8192',
        'wsize=8192',
        'timeo=14'
        ]
    else
      config.vm.synced_folder ".", "/var/www", :mount_options => ["dmode=777", "fmode=666"]
    end

    # WPDistillery Windows Support
    if Vagrant::Util::Platform.windows?
      config.vm.provision "shell",
      inline: "echo \"Converting Files for Windows\" && sudo apt-get install -y dos2unix && cd /var/www/ && dos2unix wpdistillery/config.yml && dos2unix wpdistillery/provision.sh && dos2unix wpdistillery/wpdistillery.sh",
      run: "always", privileged: false
    end

    # Run Provisioning – executed within the first `vagrant up` and every `vagrant provision`
    config.vm.provision "shell", path: "wpdistillery/provision.sh"

    # OPTIONAL - Update WordPress and all Plugins on vagrant up – executed within every `vagrant up`
    #config.vm.provision "shell", inline: "echo \"== Update WordPress & Plugins ==\" && cd /var/www/public && wp core update && wp plugin update --all", run: "always", privileged: false

    # OPTIONAL - Enable NFS. Make sure to remove line 13 (See https://stefanwrobel.com/how-to-make-vagrant-performance-not-suck)
    #config.vm.synced_folder ".", "/var/www", :nfs => { :mount_options => ["dmode=777","fmode=666"] }

end
