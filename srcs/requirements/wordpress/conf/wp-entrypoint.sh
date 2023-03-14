#!/bin/bash
if [ ! -e wp-config.php ]
then
	wp core download --locale=fr_FR

	wp config create --dbname=${WORDPRESS_DB_NAME} \
	--dbuser=${WORDPRESS_DB_USER} \
	--dbpass=${WORDPRESS_DB_PASSWORD} \
	--dbhost=${WORDPRESS_DB_HOST}

	# wp db create --dbuser=${WORDPRESS_DB_USER} \
	# --dbpass=${WORDPRESS_DB_PASSWORD}

	wp core install --url=${WORDPRESS_URL} \
	--title="${WORDPRESS_TITLE}" \
	--admin_user=${WORDPRESS_ADMIN} \
	--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
	--admin_email=${WORDPRESS_EMAIL}
fi

php-fpm8 -F
