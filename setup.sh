#!/usr/bin/env bash
#
# WP SETUP FILE
#
# Author: Flurin Dürst » github.com/flurinduerst
# URL: https://github.com/flurinduerst/ScWPSetup
#
# Version: 1.3

set -e

# REQUIREMENTS
####################################################################################################

# YAML PARSER FUNCTION
function parse_yaml() {
    local prefix=$2
    local s
    local w
    local fs
    s='[[:space:]]*'
    w='[a-zA-Z0-9_]*'
    fs="$(echo @|tr @ '\034')"
    sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s[:-]$s\(.*\)$s\$|\1$fs\2$fs\3|p" "$1" |
    awk -F"$fs" '{
    indent = length($1)/2;
    vname[indent] = $2;
    for (i in vname) {if (i > indent) {delete vname[i]}}
        if (length($3) > 0) {
            vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
            printf("%s%s%s=(\"%s\")\n", "'"$prefix"'",vn, $2, $3);
        }
    }' | sed 's/_=/+=/g'
}

# DEFINE COLORS
RED='\033[0;31m' # error
GRN='\033[0;32m' # success
BLU='\033[0;34m' # task
BRN='\033[0;33m' # headline
NC='\033[0m' # No Color

BOLD='\033[0;1m'
NB='\033[0;22m'

# EXECUTIVE SETUP
####################################################################################################

printf "${BRN}========== SETUP START ==========${NC}\n\n"

# READ CONFIG
eval $(parse_yaml config.yml "CONF_")
cd public

# INSTALL WORDPRESS
if [ $CONF_installation_wp = true ]; then
  printf "${BRN}[=== INSTALL WORDPRESS ===]${NC}\n"
  printf "${BLU}»»» downloading WordPress...${NC}\n"
  wp core download --locale=$CONF_locale
  printf "${BLU}»»» creating wp-config...${NC}\n"
  wp core config --dbname=$CONF_db_name --dbuser=$CONF_db_user --dbpass=$CONF_db_pass --dbprefix=$CONF_db_prefix --locale=$CONF_locale
  printf "${BLU}»»» installing wordpress...${NC}\n"
  wp core install --url=$CONF_settings_url --title="$CONF_settings_title" --admin_user=$CONF_admin_user --admin_password=$CONF_admin_password --admin_email=$CONF_admin_email
  printf "${BLU}»»» configure settings...${NC}\n"
  wp rewrite structure $CONF_settings_rewrite_structure
else
  printf "${BLU}-> skipping WordPress installation...${NC}\n"
fi

# INSTALL THEME
if [ $CONF_installation_theme = true ]; then
  printf "${BRN}[=== INSTALL $CONF_theme_name ===]${NC}\n"
  printf "${BLU}»»» downloading $CONF_theme_name...${NC}\n"
  wp theme install $CONF_theme_url
  printf "${BLU}»»» installing/activating $CONF_theme_name...${NC}\n"
  mv wp-content/themes/$CONF_theme_name-master wp-content/themes/$CONF_theme_name
  wp theme activate $CONF_theme_name
else
  printf "${BLU}»»» skipping theme installation...${NC}\n"
fi

# CLEANUP
if [ $CONF_installation_cleanup = true ]; then
  printf "${BRN}[=== CLEANUP ===]${NC}\n"
  if [ $CONF_installation_cleanup_comment = true ]; then
    printf "${BLU}»»» removing default comment...${NC}\n"
    wp comment delete 1 --force
  fi
  if [ $CONF_installation_cleanup_posts = true ]; then
    printf "${BLU}»»» removing default posts...${NC}\n"
    wp post delete 1 --force
  fi
  if [ $CONF_installation_cleanup_files = true ]; then
    printf "${BLU}»»» removing WP readme/license files...${NC}\n"
    rm readme.html
    rm liesmich.html
    rm license.txt
  fi
  if [ $CONF_installation_cleanup_themes = true ]; then
    printf "${BLU}»»» removing default themes...${NC}\n"
    wp theme delete twentyfourteen
    wp theme delete twentyfifteen
    wp theme delete twentysixteen
  fi
else
  printf "${BLU}»»» skipping Cleanup...${NC}\n"
fi

# PLUGINS
if [ $CONF_installation_plugins = true ]; then
  printf "${BRN}[=== PLUGINS ===]${NC}\n"
  printf "${BLU}»»» removing WP default plugins${NC}\n"
  wp plugin delete akismet
  wp plugin delete hello
  printf "${BLU}»»» adding active plugins${NC}\n"
  for entry in "${CONF_plugins_active[@]}"
  do
  	wp plugin install $entry --activate
  done

  printf "${BLU}»»» adding inactive plugins${NC}\n"
  for entry in "${CONF_plugins_inactive[@]}"
  do
    wp plugin install $entry
  done
else
  printf "${BLU}»»» skipping Plugin installation...${NC}\n"
fi

# MISC
printf "${BLU}»»» checking wp cli version${NC}\n"
wp cli check-update

printf "${BRN}========== SETUP FINISHED ==========${NC}\n"
