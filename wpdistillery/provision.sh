#!/usr/bin/env bash
#
# WPDIstillery provisioning file
#
# Author: Flurin Dürst » github.com/flurinduerst
# URL: https://github.com/flurinduerst/WPDistillery
# Note: created with WPDistillery 2.0.0
#
# File version 1.0.0

# update WP-CLI
echo "== Update WP CLI =="
sudo wp cli update --yes --allow-root

# set upload size to 64MB
echo "== Update Max Filesize =="
sudo sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 64M/g' /etc/php5/apache2/php.ini
sudo sed -i 's/post_max_size = 8M/post_max_size = 64M/g' /etc/php5/apache2/php.ini
sudo service apache2 restart

# run WPDistillery
echo "== Run WPDistillery =="
cd ../../var/www/wpdistillery
sudo -u vagrant bash wpdistillery.sh
