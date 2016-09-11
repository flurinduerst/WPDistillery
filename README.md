
![Screenshot](http://files.flurinduerst.ch/wpdistillery/wpdistillery_logo.png)

**Version:** 1.7.2

**Update Note:** Version 1.7 brings lots of new settings. Check out the [configuration file documentation](README_CONFIG.md).

## What/How/Why
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
```bash
git clone https://github.com/scotch-io/scotch-box.git && mv scotch-box/public public && mv scotch-box/Vagrantfile Vagrantfile && rm -rf scotch-box && git clone --depth 1 https://github.com/flurinduerst/WPDistillery.git && mv WPDistillery/config.yml config.yml && mv WPDistillery/setup.sh setup.sh && rm -rf WPDistillery

```
2. add environment variables and your preferred options into `config.yml` (see [configuration file documentation](README_CONFIG.md) for additional info on `config.yml`)
4. `vagrant up` then `vagrant ssh`
5. update wp cli `sudo wp cli update --allow-root` see [Known Issues](https://github.com/flurinduerst/WPDistillery#known-issues)
6. execute setup.sh `cd ../../var/www/ && bash setup.sh`
7. access your project at  http://192.168.33.10/

## Known Issues
* Currently Scotch Box comes with `WP-CLI 0.20.3` The WP-CLI released compatibility updates for WordPress 4.4 and now requires Version `0.20.4+`. Please update wp cli on the VM with `sudo wp cli update --allow-root`. See [issue#158](https://github.com/scotch-io/scotch-box/issues/158)
* When using Wordmove (install it with `gem install wordmove` on the VM) you have to complete the locale settings by adding them to `.bashrc`:
```
echo "export LANGUAGE=en_US.UTF-8">>~/.bashrc
echo "export LC_ALL=en_US.UTF-8 ">>~/.bashrc
```
then `exit` and `vagrant ssh` and you're good to go. (This is a ScotchBox issue but I wanted to clarify this for everyone using Wordmove.)

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
