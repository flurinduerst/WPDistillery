![Screenshot](http://files.flurinduerst.ch/wpdistillery/wpdistillery_logo.png)

**Version 2.3.5** (11.06.2018)

Since V2.1.0 WPDistillery is fully compatible with Scotch Box 3.0

[wpdistillery.org](https://wpdistillery.org)

## What is WPDistillery?
WP Distillery does all the work for you when setting up a new WordPress project with [Scotch Box](https://box.scotch.io/). Simply add your preferred theme, plugins, options etc. into `config.yml` and you're good to go. With WPDistillery it won't take longer than 5 minutes until you can start working on your new WordPress project.
One simple command will:
- install Scotch Box
- install/update requirements on the local webserver
- download/install/configure WordPress
- set WordPress options
- install/activate your favorite WordPress theme (default [WPSeed](https://wpseed.org)).
- remove default themes
- install/activate the plugins you defined in the config
- clean WordPress defaults (contents, plugins, unused files)

You're able to adjust which of the above tasks will be executed. Simply set the desired tasks to true/false in the "Setup Options" section at the bottom of  `config.yml`

All you need to do after customizing your config file is `vagrant up`. That's it! With that one single command, WPDistillery will now ssh to the VM, update WP-CLI, install and configure everything. It also comes with an optional auto-update function and integrated support for Windows. Check out the [Changelog](CHANGELOG.md) for a complete list of changes.

For your next project, you can use your `config.yml` as a personal template.

## Demo

[![WPDistillery Setup Video](http://files.flurinduerst.ch/wpdistillery/demovideo_thumb2.png)](https://youtu.be/y1GtIiODsxM)

## Dependencies
- [ScotchBox](https://box.scotch.io) (using [Vagrant](https://vagrantup.com) & [Virtualbox](https://virtualbox.org))
- [Vagrant Hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) (`vagrant plugin install vagrant-hostsupdater`)

## Setup
To setup a new project running Scotch Box and WordPress, simply follow these steps:

1. `git clone https://github.com/flurinduerst/WPDistillery.git my-project`
2. customize `wpdistillery/config.yml` (see [configuration file documentation](README_CONFIG.md))
3. in `Vagrantfile`, add your local URL at `config.vm.hostname` (This should be the same as `wpsettings:url:` in `config.yml`)
4. Run `vagrant up` inside your project root

Done! You can now access your project at the local URL (for example `yoursite.vm`) defined in step 3. (or at http://192.168.33.10/)

Note: Windows users may wish to `vagrant plugin install vagrant-winnfsd` before `vagrant up` for a moderate speed increase on sites with a lot of files. WPDistillery will detect WinNFSd support if needed. See [Vagrant WinNFSd](https://github.com/winnfsd/vagrant-winnfsd).


## Additional Information

#### WPDistillery with WP-Multisite
Using this [Pull Request](https://github.com/flurinduerst/WPDistillery/pull/45) you can add multisite capability for your project. We [decided](https://github.com/flurinduerst/WPDistillery/issues/59) to not merge the PR to keep WPDistillery as clean as it is.

#### Auto Update WordPress and Plugins
If you want to automatically update WordPress and all Plugins on every `vagrant up` you can remove the comment character at line 26 inside the Vagrantfile.

#### Windows Support
Using Windows? No Problem! WPDistillery will detect if you're using Windows and if so, automatically convert all files using dos2unix.

#### Vagrant commands
* `vagrant up` will start the machine. The first ever `vagrant up` in your project will also install Scotch Box and execute provisioning
* `vagrant provision` will execute provisioning. This is where WPDistillery runs its core function which is installing and configuring WordPress according to `config.yml`. Before that, it will also update WP-CLI and set the upload size to 64MB. Normally `vagrant provision` should not be executed manually but can be used to re-run the WPDistillery setup in case you want to re-install WordPress.
* `vagrant reload` will restart vagrant. This is required for changes made in the Vagrantfile to take effect.
* `vagrant halt` will shut down the running machine.
* `vagrant destroy` will destroy all the resources related to the current VM.
* More informations can be found at [vagrantup.com](https://vagrantup.com).

## Troubleshooting
Something went wrong within the WPDistillery setup. I'd like to restart the setup:
* fix your setting (probably in `wpdistillery/config.yml` or `Vagrantfile`)
* remove all tables from the `scotchbox` database
* remove the `public` folder
* run `vagrant reload --provision`

## About

* Author: [Flurin Dürst](https://github.com/flurinduerst) - [Twitter](https://twitter.com/flurinduerst)
* Contributors:
  * [@ShaneShipston](https://github.com/ShaneShipston)
  * [@drawcard](https://github.com/drawcard)
  * [@thursby](https://github.com/thursby)

### Contribution
* Fork it
* Create your feature branch
* Commit your changes
* Push to the branch
* Create new Pull Request

Feel free to contact me if you have questions or need any advice.

### License
WPDistillery is released under the MIT Public License.

Note: The "About" section in `README.md` and the author (`@author`) notice in the file-headers shall not be edited or deleted without permission. For details, please see [License](LICENSE).

I’m putting a lot of time into maintaining WPDistillery, so please consider [donating](https://www.paypal.me/FlurinDuerst/10) or [sharing](https://twitter.com/intent/tweet?url=https%3A%2F%2Fwpdistillery.org). Thank you!
