#!/bin/sh -l

# Setup WordPress installation and add WooCommerce plugin
cd /usr/src/wordpress/

wp config create --dbname=$1 --dbuser=$2 --dbpass=$3 --dbhost=$4 --allow-root
wp core install --url=http://localhost:8080 --title=Test --admin_user=$5 --admin_password=$6 --admin_email=admin@local.test --skip-email --allow-root
wp plugin install woocommerce --activate --allow-root

# Prepare the plugin
cd /github/workspace

# Setup new .env.testing
yes | cp .env.actions.testing .env.testing

# Copy plugin from the workspace in the WordPress plugins folder and run everything from there
cp -R /github/workspace /usr/src/wordpress/wp-content/plugins/woo-solo-api

cd /usr/src/wordpress/wp-content/plugins/woo-solo-api

# Setup Composer
composer install --no-progress

# Install npm packages
npm install
npm run build

pwd
ls -all
cd src/Core && ls -all
cd ..
cd ..
cd tests && ls -all
cd Integration && ls -all
cd ..

# Run integration tests
composer test:integration
