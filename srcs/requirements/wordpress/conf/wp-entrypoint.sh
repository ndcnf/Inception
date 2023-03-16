#!/bin/bash
if [ ! -e wp-config.php ]
then
	wp core download --locale=fr_FR

	while ! mysqladmin --host=${WORDPRESS_DB_HOST} --user=${DB_USER} --password=${DB_USER_PASSWORD} ping --silent;
	do
	sleep 1
	done

	wp config create --dbname=${WORDPRESS_DB_NAME} \
	--dbuser=${WORDPRESS_DB_USER} \
	--dbpass=${WORDPRESS_DB_PASSWORD} \
	--dbhost=${WORDPRESS_DB_HOST}

	wp core install --url=${WORDPRESS_URL} \
	--title="${WORDPRESS_TITLE}" \
	--admin_user=${WORDPRESS_ADMIN} \
	--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
	--admin_email=${WORDPRESS_EMAIL}

	wp user create ${WORDPRESS_DB_USER} \
	${WORDPRESS_USER_EMAIL} \
	--user_pass=${WORDPRESS_DB_PASSWORD} \
	--role=author \
	--porcelain

fi

# force to stay in foreground, and ignore daemonize option from config file
php-fpm8 -F
