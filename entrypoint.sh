#!/bin/sh -l

wp config create --dbname=$1 --dbuser=$2 --dbpass=$3 --dbhost=$4 --allow-root
wp core install --url=http://localhost:8080 --title=Test --admin_user=$5 --admin_password=$6 --admin_email=admin@local.test --skip-email --allow-root
wp plugin install woocommerce --activate --allow-root
