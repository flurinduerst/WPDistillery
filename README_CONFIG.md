
# The configuration file in detail

In this section, we will go through the `config.yml` step by step as I will explain the options available.

The configuration file is split into five sections:

* Installation
* Wordpress
* Themes
* Plugins
* WPDistillery Setup

## Installation
* In **`wpversion`** you can define what WordPress version to install.
* With **`wplocale`** you can select what language to download and install WordPress. Use language Codes like `en_US` or `en_GB`.
* Add your timezone as string to **`timezone`**. See [List of Supported Timezones](http://php.net/manual/en/timezones.php).
* **`admin`** defines the default admin user. Set your preferred username, password and email.
* **`db`** contains the access data to connect WordPress to the database on the Virtual Machine. By default (when using ScotchBox) no changes are needed here.

```yaml
# INSTALLATION
#################################################################

# WordPress version
wpversion: latest

# language/timezone
wplocale: en_US
timezone: America/New_York

# admin user settings
admin:
  user: admin
  password: admin
  email: mail@domain.tld

# scotch box db access
db:
  name: scotchbox
  user: root
  pass: root
  prefix: wp_
```

## Settings
* In **`wpsettings`** you can define WP-Options like url, title, description, the permalink_structure or edit the default image sizes.
* Set **`page_on_front`** to true to set **`frontpage_name`** as default front page.
* If you set **`convert_smilies`** false, smilies wont be converted to image-smilies automatically.
* Note: To edit the url you use to access the website within your browser edit `config.vm.hostname` in the Vagrantfile from Scotch Box.

```yaml
# SETTINGS
#################################################################

wpsettings:
  url: wpdistillery.vm
  title: Example
  description: Example Description
  permalink_structure: /%postname%/
  # default image sizes
  thumbnail_width: 150
  thumbnail_height: 150
  medium_width: 300
  medium_height: 300
  large_width: 1024
  large_height: 1024
  # use page as frontpage
  page_on_front: true
    frontpage_name: Example Front Page
  # automatic converttion of smilies
  convert_smilies: false
```

## Themes
Now you can install a (starter-) theme if you want. Simply add the name and download-url of the theme. WP Distillery will then download, unzip and install the theme. If you do not leave **`rename`** empty, it will also rename the installed theme folder. By default, WPDistillery will also delete the delete the default WordPress themes defined at **`remove`**. If you don't want this, just leave it empty: `remove: ""`.

```yaml
# THEMES
#################################################################

# install a custom theme via url, rename it and remove default themes
themes:
  name: WPSeed
  url: "https://github.com/flurinduerst/WPSeed/archive/master.zip"
  rename: ""
  remove:
    - twentyfifteen
    - twentysixteen
    - twentyseventeen
```

## Plugins
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
  - google-sitemap-generator

# plugins to install
plugins_inactive:
  #development
  - custom-post-type-ui
  - search-and-replace
  - capability-manager-enhanced
  #administration
  - adminimize
  - admin-menu-editor
  - admin-menu-reorder
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

## WPDistillery Setup
Maybe you don't want WP Distillery to install a theme? Or you prefer keeping the default posts and files it comes with? Within the setup options at the bottom of the file you can tell WP Distillery which tasks to perform. Simply set those you wan't to skip to `false`.

* **`wp`**: install WordPress core
* **`settings`**: set custom WordPress settings (Note: the value defined **`timezone`** is also considered a setting)
* **`themes`**: install and activate the theme defined above and delete defined default themes
* **`plugins`**: install the plugins listed
* **`cleanup`**: delete WordPress defaults as followed
  * **`comment`**: the default comment
  * **`posts`**: the default post
  * **`files`**: `readme.html`, `license.txt`


```yaml
# WPDISTILLERY SETUP
####################################################################
# if you don't want the setup to run all tasks set them to false

setup:
  wp: true
  settings: true
  themes: true
  plugins: true
  cleanup: true
    comment: true
    posts: true
    files: true
```
