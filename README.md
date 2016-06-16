# WordPress Setup for Scotch Box
Version: 1.3

### What/How/Why
ScWPSetup does all the work for you when setting up a new project with [scotchbox](https://box.scotch.io/). After adding your theme, plugins and environment variables into `config.yml` you simply execute `setup.sh` and it will
- download/install/configure WordPress
- install/activate your favorite WP Theme (default [WPSeed](https://wpseed.org)).
- install/activate the Plugins you defined in the config
- define WordPress options
- clean WordPress defaults (contents, plugins, themes, readme, license)

You can then re-use your config.yml for every other project and save a lot of time clicking, dragging, editing and configurating.

### Requirements:
- running [scotchbox](https://box.scotch.io/) with vagrant/virtualbox (see [getting startet with Scotch Box](https://scotch.io/bar-talk/introducing-scotch-box-a-vagrant-lamp-stack-that-just-works))

You can use this setup with any other vagrantbox, altough it is written especially for scotchbox and you'll have to adjust some settings/paths.

### Setup
To setup a new project simply follow these steps:

1. install [scotchbox](https://box.scotch.io/) into project root `git clone https://github.com/scotch-io/scotch-box.git`
2. install ScWPSetup into project root `git clone https://github.com/flurinduerst/ScWPSetup.git`
3. edit `config.yml` with whatever you need/want
4. `vagrant up` then `vagrant ssh`
5. update wp cli (`sudo wp cli update --allow-root` and confirm)
6. `cd ../../var/www && bash setup.sh`

Steps 1 and 2 including managing git folders in one command: `git clone https://github.com/scotch-io/scotch-box.git && mv scotch-box/public public && mv scotch-box/Vagrantfile Vagrantfile && rm -rf scotch-box && git clone --depth 1 git@github.com:flurinduerst/ScWPSetup.git && mv ScWPSetup/config.yml config.yml && mv ScWPSetup/setup.sh setup.sh && rm -rf ScWPSetup`

The setup will look similar to this:

<img src="screenshot.png"/>
