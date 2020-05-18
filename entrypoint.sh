#!/bin/sh -l

cd /usr/src/wordpress/

wp config create --dbname=$1 --dbuser=$2 --dbpass=$3 --dbhost=$4 --allow-root
wp core install --url=http://localhost:8080 --title=Test --admin_user=$5 --admin_password=$6 --admin_email=admin@local.test --skip-email
wp plugin install woocommerce --activate --allow-root

cd /github/workspace

# Setup Composer
composer install --no-progress

# Install npm packages
npm install
npm run build

# Setup new .env.testing
yes | cp .env.actions.testing .env.testing

cp -R /github/workspace /usr/src/wordpress/wp-content/plugins/woo-solo-api

# Run integration tests
composer test:integration
