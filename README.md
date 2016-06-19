# WordPress Setup for Scotch Box
***Version:*** 1.4

![Screenshot](http://flurinduerst.ch/web/ScWPSetup/scotch_plus_wp.png)

#### What/How/Why
ScWPSetup does all the work for you when setting up a new WordPress project with [Scotch Box](https://box.scotch.io/). Simply add your preferred theme, plugins, options etc. into `config.yml` and your good to go. With ScWPSetup it won't take you no longer than 5 minutes until you can start working on your new WordPress project.
Executing setup.sh then will
- download/install/configure WordPress
- set WordPress options
- install/activate your favorite WordPress theme (default [WPSeed](https://wpseed.org)).
- install/activate the plugins you defined in the config
- clean WordPress defaults (contents, plugins, themes, unused files)

***You're able to adjust wich of the above tasks will be executed. Simply set the desired tasks to true/false in the "Setup Options" section at the bottom of  `config.yml`***

Now you can use your `config.yml` as a template for every new project and save a lot of time clicking, dragging, editing and configuring.

See this [Screenshot](http://flurinduerst.ch/web/ScWPSetup/setup_screenshot.png) for a preview of how the setup will look like.

#### Dependencies
- ssh access to your VM/host
- [wp cli](https://wp-cli.org/) 0.23+ on your VM/host

ScWPSetup is made to work with [Scotch Box](https://box.scotch.io/). Since `ScWPSetup Version 1.3.1+` you can edit the WordPress root folder so you should be able to run with any other vagrantbox or webhost (see [ScWPSetup when not using Sotch Box](https://github.com/flurinduerst/ScWPSetup#setup-when-not-using-scotch-box)).


## Setup
To setup a new project running Scotch Box and WordPress simply follow these steps:

1. Run the following command inside `var/www` to install Scotch Box & ScWPSetup:
`git clone https://github.com/scotch-io/scotch-box.git && mv scotch-box/public public && mv scotch-box/Vagrantfile Vagrantfile && rm -rf scotch-box && git clone --depth 1 git@github.com:flurinduerst/ScWPSetup.git && mv ScWPSetup/config.yml config.yml && mv ScWPSetup/setup.sh setup.sh && rm -rf ScWPSetup`
2. add environment variables and your preferred options into `config.yml` (see [FAQ](https://github.com/flurinduerst/ScWPSetup/blob/master/README.md) for additional info on config.yml)
4. `vagrant up` then `vagrant ssh`
5. update wp cli `sudo wp cli update --allow-root` see [Known Issues](https://github.com/flurinduerst/ScWPSetup#known-issues)
6. execute setup.sh `cd ../../var/www/ && bash setup.sh`


#### Setup when not using Scotch Box
1. install your vagrantbox of choice or use your webhost for the following steps
2. clone ScWPSetup into project
2. add environment variables and your preferred options into `config.yml` (see [FAQ](https://github.com/flurinduerst/ScWPSetup/blob/master/README.md) for additional info on config.yml)
4. `ssh` to your VM/host
5. execute `setup.sh`

#### Known Issues
* Currently Scotch Box comes with `WP-CLI 0.20.3` The WP-CLI released compatibility updates for WordPress 4.4 and now requires Version `0.20.4+`. Please update wp cli on the VM with `sudo wp cli update --allow-root`. See [issue#158](https://github.com/scotch-io/scotch-box/issues/158)

##### About
* Author: Flurin Dürst
* Contact: [flurin@flurinduerst.ch](mailto:flurin@flurinduerst.ch)
* Twitter: [@flurinduerst](https://twitter.com/flurinduerst)

##### Contribution
Feel free to contact me or add issues/pull-requests.

##### License
WPSeed is released under the terms of the GNU General Public License

## Like it? Awesome!
If you find this tool useful, consider supporting ScWPSetup or [buying me a glass of single malt scotch whiskey](https://www.paypal.me/FlurinDuerst/10) :)
