# v 2.0 BETA

### This is a Beta Testing Branch.
### This build is unfinished. Do not use for production.

**Version:** 2.0.0

Todo:
* [x] Move WPDistillery to /wpdistillery
* [x] Add custom Vagrantfile to automate setup within vagrant up and add requirements/updates
* [x] Add functionality to auto update on vagrant up
* [ ] hostmanager
* [ ] NFS stuff
* [ ] complete Readme where incomplete parts are marked with *****

---------------------------------------------------------------------

![Screenshot](http://files.flurinduerst.ch/wpdistillery/wpdistillery_logo.png)

**Version:** 1.8.0

**Update Note:** Version 1.7 brings lots of new settings. Check out the [configuration file documentation](README_CONFIG.md).

For additional information, visit the [Official WPDistillery Website](https://wpdistillery.org). The Documentation at wpdistillery.org is synced with the Github repository files.

## What/How/Why
***** add note about "vagrant up will do everything since 2.0"*****
WP Distillery does all the work for you when setting up a new WordPress project with [Scotch Box](https://box.scotch.io/). Simply add your preferred theme, plugins, options etc. into `config.yml` and your good to go. With WPDistillery it won't take you no longer than 5 minutes until you can start working on your new WordPress project.
Executing setup.sh then will
- download/install/configure WordPress
- set WordPress options
- install/activate your favorite WordPress theme (default [WPSeed](https://wpseed.org)).
- install/activate the plugins you defined in the config
- clean WordPress defaults (contents, plugins, themes, unused files)

You're able to adjust wich of the above tasks will be executed. Simply set the desired tasks to true/false in the "Setup Options" section at the bottom of  `config.yml`

Now you can use your `config.yml` as a template for every new project and save a lot of time clicking, dragging, editing and configuring.

Watch [WPDistillery in action](https://youtu.be/sQqeCtFso3o) or see this [Screenshot](http://files.flurinduerst.ch/wpdistillery/setup_screenshot.jpg) for a preview of how the setup will look like.


## Dependencies
- ssh access to your VM/host
- [wp cli](https://wp-cli.org/) 0.23+ on your VM/host

WP Distillery is designed for [Scotch Box](https://box.scotch.io/). Since `WPDistillery Version 1.3.1+` you can edit the WordPress root folder so you should be able to run it with any other vagrantbox or webhost.


## Setup
To setup a new project running Scotch Box and WordPress simply follow these steps:

1. Run the following command inside your project root to install both Scotch Box & WPDistillery:

  ```
  git clone https://github.com/scotch-io/scotch-box.git && mv scotch-box/public public && rm -rf scotch-box && git clone -b 2.0beta https://github.com/flurinduerst/WPDistillery.git mv WPDistillery/Vagrantfile Vagrantfile && mv WPDistillery/wpdistillery wpdistillery2 && rm -rf WPDistillery && mv wpdistillery2 wpdistillery
  ```

2. customize `wpdistillery/config.yml` (see [configuration file documentation](README_CONFIG.md) for additional info)
3. ***** add note about domain ******
4. `vagrant up`
5. Done! You can now access your project at  http://192.168.33.10/ or the domain defined in step #3.

***** add note about windows support in Vagrantfile *****

***** add note about functionality of vagrant up and vagrant provision *****
***** first vagrant up:  WPDistillery will initialize your vagrant box, update/install requirements like WP-CLI, install WordPress and add your settings defined in config.yml to the WordPress installation.*****

Thanks to [@rowboat85](https://github.com/rowboat85) and [@ShaneShipston](https://github.com/ShaneShipston) for pointing this out.

## Known Issues
* Currently Scotch Box comes with `WP-CLI 0.20.3` Since WordPress 4.4 Version `0.20.4+` is required. Please update wp cli on the VM with `sudo wp cli update --allow-root`. See [issue#158](https://github.com/scotch-io/scotch-box/issues/158)

## About
* Author: Flurin Dürst
* Contact: [flurin@flurinduerst.ch](mailto:flurin@flurinduerst.ch)
* Twitter: [@flurinduerst](https://twitter.com/flurinduerst)

### Contribution
Feel free to contact me or add issues/pull-requests.

### License
WPDistillery is released under an edited version of the MIT License. Please see [License](LICENSE.md).

### Like it? Awesome!
If you find this tool useful, consider supporting WP Distillery or [buying me a beer](https://www.paypal.me/FlurinDuerst/5) respectively [a glass of single malt scotch whiskey](https://www.paypal.me/FlurinDuerst/10) :)
