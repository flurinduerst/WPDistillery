#!/usr/bin/env bash
#
# WPDistillery setup file
#
# Author: Flurin Dürst
# URL: https://wpdistillery.org
#
# File version 1.8.3

# ERROR Handler
# ask user to continue on error
function continue_error {
  read -p "$(echo -e "${RED}Do you want to continue anyway? (y/n) ${NC}")" -n 1 -r
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    printf "\n${RED}»»» aborting WPDistillery setup! ${NC}\n"
    exit 1
  else
    printf "\n${GRN}»»» continuing WPDistillery setup... ${NC}\n"
  fi
}
trap 'continue_error' ERR

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
NC='\033[0m' # no color

# EXECUTIVE SETUP
####################################################################################################

printf "${BRN}========== WPDISTILLERY START ==========${NC}\n\n"

# MOVE TO SYNCED DIRECTORY
cd ..

# READ CONFIG
eval $(parse_yaml wpdistillery/config.yml "CONF_")


# CHECK FOR ROOT-DIR
if [ ! -d "public" ]; then
  printf "${BLU}»»» creating root dir \"public\"...${NC}\n"
  mkdir public
fi

# navigate to root dir
cd public

# INSTALL WORDPRESS
if $CONF_setup_wp ; then
  printf "${BRN}[=== INSTALL WORDPRESS ===]${NC}\n"
  printf "${BLU}»»» downloading WordPress...${NC}\n"
  wp core download --locale=$CONF_wplocale --version=$CONF_wpversion
  printf "${BLU}»»» creating wp-config...${NC}\n"
  wp core config --dbname=$CONF_db_name --dbuser=$CONF_db_user --dbpass=$CONF_db_pass --dbprefix=$CONF_db_prefix --locale=$CONF_wplocale
  printf "${BLU}»»» installing WordPress...${NC}\n"
  wp core install --url=$CONF_wpsettings_url --title="$CONF_wpsettings_title" --admin_user=$CONF_admin_user --admin_password=$CONF_admin_password --admin_email=$CONF_admin_email --skip-email
  wp user update 1 --first_name=$CONF_admin_first_name --last_name=$CONF_admin_last_name
else
  printf "${BLU}>>> skipping WordPress installation...${NC}\n"
fi

if $CONF_setup_settings ; then
  printf "${BLU}»»» configure settings...${NC}\n"
  printf "» timezone:\n"
  wp option update timezone $CONF_timezone
  wp option update timezone_string $CONF_timezone
  printf "» permalink structure:\n"
  wp rewrite structure "$CONF_wpsettings_permalink_structure"
  wp rewrite flush --hard
  printf "» description:\n"
  wp option update blogdescription "$CONF_wpsettings_description"
  printf "» image sizes:\n"
  wp option update thumbnail_size_w $CONF_wpsettings_thumbnail_width
  wp option update thumbnail_size_h $CONF_wpsettings_thumbnail_height
  wp option update medium_size_w $CONF_wpsettings_medium_width
  wp option update medium_size_h $CONF_wpsettings_medium_height
  wp option update large_size_w $CONF_wpsettings_large_width
  wp option update large_size_h $CONF_wpsettings_large_height
  if ! $CONF_wpsettings_convert_smilies ; then
    wp option update convert_smilies 0
  fi
  if $CONF_wpsettings_page_on_front ; then
    printf "» front page:\n"
    # create and set frontpage
    wp post create --post_type=page --post_title="$CONF_wpsettings_frontpage_name" --post_content='Front Page created by WPDistillery' --post_status=publish
    wp option update page_on_front $(wp post list --post_type=page --post_status=publish --posts_per_page=1 --pagename="$CONF_wpsettings_frontpage_name" --field=ID --format=ids)
    wp option update show_on_front 'page'
  fi
else
  printf "${BLU}>>> skipping settings...${NC}\n"
fi

# INSTALL/REMOVE THEME
if $CONF_setup_theme ; then
  printf "${BRN}[=== CONFIGURE THEME ===]${NC}\n"
  printf "${BLU}»»» downloading $CONF_theme_name...${NC}\n"
  wp theme install $CONF_theme_url --force
  printf "${BLU}»»» installing/activating $CONF_theme_name...${NC}\n"
  if [ ! -z "$CONF_theme_rename" ]; then
    # rename theme
    printf "${BLU}»»» renaming $CONF_theme_name to $CONF_theme_rename...${NC}\n"
    mv wp-content/themes/$CONF_theme_name wp-content/themes/$CONF_theme_rename
    wp theme activate $CONF_theme_rename
  else
    wp theme activate $CONF_theme_name
  fi
  if [ ! -z "$CONF_theme_remove" ]; then
    printf "${BLU}»»» removing default themes...${NC}\n"
    # loop trough themes that shall be removed
    for loopedtheme in "${CONF_theme_remove[@]}"
    do :
      #make sure the theme to delete is not the chosen one
      if [ $loopedtheme != $CONF_theme_name ]; then
        printf "${BLU}» removing $loopedtheme...${NC}\n"
        wp theme delete $loopedtheme

      fi
    done
    # end loop
  fi

else
  printf "${BLU}>>> skipping theme installation...${NC}\n"
fi

# CLEANUP
if $CONF_setup_cleanup ; then
  printf "${BRN}[=== CLEANUP ===]${NC}\n"
  if $CONF_setup_cleanup_comment ; then
    printf "${BLU}»»» removing default comment...${NC}\n"
    wp comment delete 1 --force
  fi
  if $CONF_setup_cleanup_posts ; then
    printf "${BLU}»»» removing default posts...${NC}\n"
    wp post delete 1 2 --force
  fi
  if $CONF_setup_cleanup_files ; then
    printf "${BLU}»»» removing WP readme/license files...${NC}\n"
    # delete default files
    if [ -f readme.html ];    then rm readme.html;    fi
    if [ -f license.txt ];    then rm license.txt;    fi
    # delete german files
    if [ -f liesmich.html ];  then rm liesmich.html;  fi
  fi
else
  printf "${BLU}>>> skipping Cleanup...${NC}\n"
fi

# PLUGINS
if $CONF_setup_plugins ; then
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
  printf "${BLU}>>> skipping Plugin installation...${NC}\n"
fi

# MISC
printf "${BLU}»»» checking wp cli version${NC}\n"
wp cli check-update

printf "${BRN}========== WPDISTILLERY FINISHED ==========${NC}\n"
