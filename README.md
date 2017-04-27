![Screenshot](http://files.flurinduerst.ch/wpdistillery/wpdistillery_logo.png)

**Version 2.0.2** (27.04.2017)

With the 2.0 update, the setup process is now much easier. All you need to do after customizing your config file is `vagrant up`. That's it! With that single command, WPDistillery will now ssh to the VM, update WP-CLI, install and configure everything. It also comes with an optional auto-update function and integrated support for Windows. Check out the [Changelog](CHANGELOG.md) for a complete list of changes.

For additional information, visit the [Official WPDistillery Website](https://wpdistillery.org). The Documentation on wpdistillery.org is synced with the Github repository files.

## What is WPDistillery?
WP Distillery does all the work for you when setting up a new WordPress project with [Scotch Box](https://box.scotch.io/). Simply add your preferred theme, plugins, options etc. into `config.yml` and you're good to go. With WPDistillery it won't take longer than 5 minutes until you can start working on your new WordPress project.
One simple command will:
- install Scotch Box
- install/update requirements on the local webserver
- download/install/configure WordPress
- set WordPress options
- install/activate your favorite WordPress theme (default [WPSeed](https://wpseed.org)).
- install/activate the plugins you defined in the config
- clean WordPress defaults (contents, plugins, themes, unused files)

You're able to adjust which of the above tasks will be executed. Simply set the desired tasks to true/false in the "Setup Options" section at the bottom of  `config.yml`

Now you can use your `config.yml` as a template for every new project and save a lot of time clicking, dragging, editing and configuring.

## Demo

[![WPDistillery Setup Video](http://files.flurinduerst.ch/wpdistillery/demovideo_thumb2.png)](https://youtu.be/y1GtIiODsxM)

[Screenshot](http://files.flurinduerst.ch/wpdistillery/setup_screenshot.jpg) (German UI)


## Dependencies
- [ScotchBox](https://box.scotch.io) (using [Vagrant](https://vagrantup.com) & [Virtualbox](https://virtualbox.org))
- [Vagrant Hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) (`vagrant plugin install vagrant-hostsupdater`)

## Setup
To setup a new project running Scotch Box and WordPress, simply follow these steps:

1. Run the following command inside your project root to clone both Scotch Box and WPDistillery and move them to the right place:

  ```
  git clone https://github.com/flurinduerst/WPDistillery.git && mv WPDistillery/Vagrantfile Vagrantfile && mv WPDistillery/wpdistillery wpdistillery2 && rm -rf WPDistillery && mv wpdistillery2 wpdistillery
  ```

2. customize `wpdistillery/config.yml` (see [configuration file documentation](README_CONFIG.md))
3. in `Vagrantfile` add your local domain at `config.vm.hostname` (This should be the same as `wpsettings:url:` in `config.yml`)
4. Run `vagrant up` inside your project root

Done! You can now access your project at the domain defined in step 3. (or at http://192.168.33.10/)

## Additional Information

### Auto Update WordPress and Plugins
If you want to automatically update WordPress and all Plugins on every `vagrant up` you can remove the comment character at line 26 inside the Vagrantfile.

### Windows Support
Using Windows? No Problem! WPDistillery will detect if you're using Windows and if so, automatically convert all files using dos2unix.

### Vagrant commands
* `vagrant up` will start the machine. The first ever `vagrant up` in your project will also install Scotch Box and execute provisioning
* `vagrant provision` will execute provisioning. This is where WPDistillery runs its core function which is installing and configuring WordPress according to `config.yml`. Before that, it will also update WP-CLI and set the upload size to 64MB. Normally `vagrant provision` should not be executed manually but can be used to re-run the WPDistillery setup in case you want to re-install WordPress.
* `vagrant reload` will restart vagrant. This is required for changes made in the Vagrantfile to take effect.
* `vagrant halt` will shut down the running machine.
* More informations can be found at [vagrantup.com](https://vagrantup.com).

## About

* Author: Flurin Dürst ([Website](https://flurinduerst.ch), [Mail](mailto:flurin@flurinduerst.ch), [Twitter](https://twitter.com/flurinduerst))
* Contributors:
  * [@ShaneShipston](https://github.com/ShaneShipston)
  * [@drawcard](https://github.com/drawcard)

### Contribution
* Fork it
* Create your feature branch
* Commit your changes
* Push to the branch
* Create new Pull Request

Feel free to contact me if you have questions or need any advice.

### License
WPDistillery is released under the MIT Public License.

Note: The "About" section in `README.md` and the author (`@author`) notice in the file-headers shall not be edited or deleted without permission. For Details see [License](LICENSE.md). Thank you.

If you find WPDistillery useful, consider [supporting](https://www.paypal.me/FlurinDuerst/10).
