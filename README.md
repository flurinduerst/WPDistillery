# WordPress Setup for Scotch Box
Version: 1.3.1

![Screenshot](http://flurinduerst.ch/web/ScWPSetup/scotch_plus_wp.png)

#### What/How/Why
ScWPSetup does all the work for you when setting up a new WordPress project with [Scotch Box](https://box.scotch.io/). Simply add your preferred theme, plugins, options etc. into `config.yml` and your good to go. With ScWPSetup it won't take you no longer than 5 minutes until you can start working on your new WordPress project.
executing setup.sh then will
- download/install/configure WordPress
- install/activate your favorite WP Theme (default [WPSeed](https://wpseed.org)).
- install/activate the Plugins you defined in the config
- define WordPress options
- clean WordPress defaults (contents, plugins, themes, unused files)

You can then re-use your `config.yml` for every other project and save a lot of time clicking, dragging, editing and configuring.

See this [Screenshot](http://flurinduerst.ch/web/ScWPSetup/setup_screenshot.png) for a preview of how the setup will look like.

#### Requirements
ScWPSetup is made to work with [Scotch Box](https://box.scotch.io/). Since Verison 1.3.1+ you can edit the WordPress root folder so you should be able to run with any other vagrantbox too. It will also work on your webhost as long as you meet the requirements:
- ssh access to your VM/host
- [wp cli](https://wp-cli.org/) 0.23+

## Setup (when using Scotch Box)
1. I prefer using [Scotch Box](https://box.scotch.io/) as my local environment. If you're using this amazing Vagrantbox too, you can simply execute the following command to install Scotch Box & ScWPSetup:
`git clone https://github.com/scotch-io/scotch-box.git && mv scotch-box/public public && mv scotch-box/Vagrantfile Vagrantfile && rm -rf scotch-box && git clone --depth 1 git@github.com:flurinduerst/ScWPSetup.git && mv ScWPSetup/config.yml config.yml && mv ScWPSetup/setup.sh setup.sh && rm -rf ScWPSetup`
2. add environment variables and your preferred options into `config.yml`
4. `vagrant ssh`
5. execute setup.sh `cd ../../var/www/ && bash setup.sh`


### Setup (when not using Scotch Box)
To setup a new project simply follow these steps:

1. install your vagrantbox of choice or use your webhost for the following steps
2. clone ScWPSetup into project root: `git clone https://github.com/flurinduerst/ScWPSetup.git  && mv ScWPSetup/config.yml config.yml && mv ScWPSetup/setup.sh setup.sh && rm -rf ScWPSetup`
3. add environment variables and your preferred options into `config.yml`
4. `ssh` to your VM/host
5. execute setup.sh


##### About
Author: Flurin Dürst
Contact: [flurin@flurinduerst.ch](mailto:flurin@flurinduerst.ch)
Twitter: [@flurinduerst](https://twitter.com/flurinduerst)

##### Contribution
Feel free to contact me or add issues/pull-requests.

##### License
WPSeed is released under the terms of the GNU General Public License
