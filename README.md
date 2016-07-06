![Screenshot](http://wpdistillery.org/sharedcontent/wpdistillery_logo.png)

***Version:*** 1.6

#### What/How/Why
WP Distillery does all the work for you when setting up a new WordPress project with [Scotch Box](https://box.scotch.io/). Simply add your preferred theme, plugins, options etc. into `config.yml` and your good to go. With WPDistillery it won't take you no longer than 5 minutes until you can start working on your new WordPress project.
Executing setup.sh then will
- download/install/configure WordPress
- set WordPress options
- install/activate your favorite WordPress theme (default [WPSeed](https://wpseed.org)).
- install/activate the plugins you defined in the config
- clean WordPress defaults (contents, plugins, themes, unused files)

You're able to adjust wich of the above tasks will be executed. Simply set the desired tasks to true/false in the "Setup Options" section at the bottom of  `config.yml`

Now you can use your `config.yml` as a template for every new project and save a lot of time clicking, dragging, editing and configuring.

Watch [WPDistillery in action](https://youtu.be/sQqeCtFso3o) or see this [Screenshot](http://wpdistillery.org/sharedcontent/setup_screenshot.jpg) for a preview of how the setup will look like.


#### Dependencies
- ssh access to your VM/host
- [wp cli](https://wp-cli.org/) 0.23+ on your VM/host

WP Distillery is made to work with [Scotch Box](https://box.scotch.io/). Since `WPDistillery Version 1.3.1+` you can edit the WordPress root folder so you should be able to run with any other vagrantbox or webhost (see [WPDistillery without using Sotch Box](https://github.com/flurinduerst/WPDistillery#setup-without-using-scotch-box)).


## Setup
To setup a new project running Scotch Box and WordPress simply follow these steps:

1. Run the following command inside your project root to install Scotch Box & WPDistillery:
```bash
git clone https://github.com/scotch-io/scotch-box.git && mv scotch-box/public public && mv scotch-box/Vagrantfile Vagrantfile && rm -rf scotch-box && git clone --depth 1 git@github.com:flurinduerst/WPDistillery.git && mv WPDistillery/config.yml config.yml && mv WPDistillery/setup.sh setup.sh && rm -rf WPDistillery
```
2. add environment variables and your preferred options into `config.yml` (see [configuration file in detail](https://github.com/flurinduerst/WPDistillery#the-configuration-file-in-detail) for additional info on config.yml)
4. `vagrant up` then `vagrant ssh`
5. update wp cli `sudo wp cli update --allow-root` see [Known Issues](https://github.com/flurinduerst/WPDistillery#known-issues)
6. execute setup.sh `cd ../../var/www/ && bash setup.sh`


#### Setup without using Scotch Box
1. install your vagrantbox of choice or use your webhost for the following steps
2. clone WP Distillery into project
2. add environment variables and your preferred options into `config.yml` (see [configuration file in detail](https://github.com/flurinduerst/WPDistillery#the-configuration-file-in-detail) for additional info on config.yml)

5. execute `setup.sh`

#### Known Issues
* Currently Scotch Box comes with `WP-CLI 0.20.3` The WP-CLI released compatibility updates for WordPress 4.4 and now requires Version `0.20.4+`. Please update wp cli on the VM with `sudo wp cli update --allow-root`. See [issue#158](https://github.com/scotch-io/scotch-box/issues/158)
* When using Wordmove (install it with `gem install wordmove` on the VM) you have to complete the locale settings by adding them to `.bashrc`:
```
echo "export LANGUAGE=en_US.UTF-8">>~/.bashrc
echo "export LC_ALL=en_US.UTF-8 ">>~/.bashrc
```
then `exit` and `vagrant ssh` and you're good to go. (This is a ScotchBox issue but I wanted to clarify this for everyone using Wordmove.)

##### About
* Author: Flurin Dürst
* Contact: [flurin@flurinduerst.ch](mailto:flurin@flurinduerst.ch)
* Twitter: [@flurinduerst](https://twitter.com/flurinduerst)

##### Contribution
Feel free to contact me or add issues/pull-requests.

##### License
WPSeed is released under the terms of the GNU General Public License

## Like it? Awesome!
If you find this tool useful, consider supporting WP Distillery or [buying me a beer](https://www.paypal.me/FlurinDuerst/5) respectively [a glass of single malt scotch whiskey](https://www.paypal.me/FlurinDuerst/10) :)


--------------------------------------------------------------
--------------------------------------------------------------


### The configuration file in detail

In this section, we will go through the `config.yml` step by step as I will explain the options available.

In ***`wpfolder`*** you define the folder containing WordPress. Within the current version of Scotch Box this is `public` by default.
With ***`wplocale`*** you can select what language to download and install WordPress. Use language Codes like `en_US` or `en_GB`.
***`admin`*** defines the default admin user. Set your preferred username, password and email.
***`db`*** contains the access data to connect WordPress to the database on the Virtual Machine. By default no changes are needed here.
```yaml
# SETUP SETTINGS
#################################################################

# WordPress folder to execute the setup
wpfolder: public
wplocale: de_CH

# admin user settings
admin:
  user: admin
  password: admin
  email: admin@mail.com

# scotch box db access
db:
  name: scotchbox
  user: root
  pass: root
  prefix: wp_
```


In ***`wpsettings`*** you can define WP-Options like the url, title and the rewrite_structure.
Note: To edit the url you use to access the website within your browser edit `config.vm.hostname` in the Vagrantfile from Scotch Box.

```yaml
# WORDPRESS SETTINGS
#################################################################

wpsettings:
  url: example.dev
  title: "My Site"
  rewrite_structure: /%postname%/
```

Now you can install a (starter-) theme if you want. Simply add the name and download-url of the theme. WP Distillery will then download, unzip and install the theme. If you do not leave `rename` empty. The it will also rename the installed theme for you.
```yaml
# THEME
#################################################################

# theme to install choose new name in 'rename' or leave empty
theme:
  name: WPSeed
  rename: ""
  url: https://github.com/flurinduerst/WPSeed/archive/master.zip
```

You can select what plugins you want WP Distillery to install for you. Split into two sections you can define which plugins to download and install, and which to also activate. By default this section contains a few recommendations.

```yaml
# PLUGINS
#################################################################

# plugins to install & activate
plugins_active:
  - disable-comments
  - duplicate-post
  - enable-media-replace
  - favicon-by-realfavicongenerator
  - regenerate-thumbnails
  - simple-page-ordering
  - user-switching

# plugins to install
plugins_inactive:
  #development
  - regenerate-thumbnails
  - custom-post-type-ui
  - search-and-replace
  - capability-manager-enhanced
  - user-switching
  - favicon-by-realfavicongenerator
  - disable-comments
  #administration
  - adminimize
  - admin-menu-editor
  - admin-menu-reorder
  - enable-media-replace
  - duplicate-post
  - simple-page-ordering
  - wordpress-seo
  #security/backup
  - wp-security-audit-log
  - backwpup
```

If you want to install custom or premium plugins you can simply write down the download-url instead of the name. Make sure to add quotes:

```yaml
plugins_active:
  - "https://example.com/plugins/awesome_plugin.zip&key=31071988"
```

Maybe you don't want WP Distillery to install a theme? Or you prefer keeping the default posts and files it comes with? Within the setup options at the bottom of the file you can tell WP Distillery which tasks to perform. Simply set those you wan't to skip to `false`.
* `wp` (default true): install WordPress core
* `theme` (default true): install and activate the theme defined above
* `plugins` (default true): install the plugins listed
* `cleanup` (default true): delete WordPress defaults as followed
  * `comment` (default true): the default comment
  * `posts` (default false): the default post
  * `files` (default true): `readme.html`, `license.txt`
  * `themes` (default true): the twentyfourteen, twentyfifteen and twentysixteen theme.

```yaml
# SETUP OPTIONS
####################################################################
# if you don't want the setup to run all tasks set them to false

installation:
  wp: true
  theme: true
  plugins: true
  cleanup: true
    comment: true
    posts: false
    files: true
    themes: true
```
