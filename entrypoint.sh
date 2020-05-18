#!/bin/sh -l

ls -all /usr/src/wordpress/
ls -all /usr/src/wordpress/wp-content/plugins
ls -all /usr/src/wordpress/wp-content/themes
cat /usr/src/wordpress/wp-config.php

# Setup Composer
composer install --no-progress

# Install npm packages
npm install
npm run build

# Setup new .env.testing
yes | cp .env.actions.testing .env.testing

# Run integration tests
composer test:integration
