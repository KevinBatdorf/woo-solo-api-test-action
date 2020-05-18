#!/bin/sh -l

cd /usr/src/wordpress/

wp config create --dbname=wordpresstest --dbuser=admin --dbpass=password --dbhost=mysql
wp plugin install woocommerce --activate

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
