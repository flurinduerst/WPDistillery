
# CHANGELOG

## HEAD (2.0.2)
* fix yaml syntax errors (thanks to @XedinUnknown)
* add license note


## 2.0.0 | 15.01.2017
* simplified setup process to `vagrant up`
* restructured file and folder structure (moved all files into a wpdistillery folder)
* added custom Vagrantfile
* added auto-update for WP-CLI
* added auto-update option for WordPress Core and Plugins
* fixed a few minor bugs
* added Windows Support

Special thanks to [@ShaneShipston](https://github.com/ShaneShipston) for his feature-suggestions and everyone involved in beta testing ([@MarcWieland95](https://github.com/marcwieland95), Anthony Chapman)

Contributors: [@FlurinDuerst](https://github.com/flurinduerst), [@ShaneShipston](https://github.com/ShaneShipston)

## 1.8.0 | 20.12.2016
* fixed a bug that occurred when sending the admin email after core installation
* fixed a bug that occurred on installing a theme from Github using the current version of WP-CLI (0.25.0)
* added an option to define WordPress Version
* documentation updates
* added rewrite flush to make sure permalinks are working correctly
* added firstname/lastname to default user
* removed google-sitemap-generator from default plugins (Yoast covers this aswell)
* added note about wpdistillery.org

Contributors: @flurinduerst, @ShaneShipston, @drawcard

## 1.7.1 | 02.08.2016
* fixed a bug that caused an error if a theme was installed that doesn't end with `master.zip`
* add additional options
  * custom page to be used as front_page
  * timezone
  * description
  * default image sizes
* add settings setup task
* small bugfixes
* cleanup/renaming

## 1.6.1 | 07.07.2016
* bugfix (now correctly checking `theme_rename`)
* add error handler that asks the user to continue if an error occured
* add google-sitemap-generator to preset plugins
* remove dublicated plugin entry
* remove WPDistillery Version from config/setup - remain at README

## 1.5.1 | 21.06.2016
* Rename to WP Distillery
* Bugfixes / Typo / Documentation

## 1.4.0 | 17.06.2016
* Add support for custom WP root folder
* Add option to rename theme after installation
* Add file versions to config.yml and setup.sh
* Fix Typo in setup procedure


## 1.3.0 | 16.06.2016
* Add modular setup task options

## 1.2.0 | 17.06.2016
* Public Release
