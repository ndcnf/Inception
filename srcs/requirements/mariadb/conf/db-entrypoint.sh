#!/bin/bash

chown -R mysql:mysql /var/lib/mysql/
chmod -R 750 /var/lib/mysql/
if [ ! -d /var/lib/mysql/mysql ]
then
	echo "Installing MariaDB..."
	mariadb-install-db --datadir=/var/lib/mysql

	/usr/bin/mariadbd-safe --datadir=/var/lib/mysql --nowatch

	# RETURN values examples: 0 OK | 2 unreachable
	while ! mysqladmin --host=${WORDPRESS_DB_HOST} ping --silent ;
	do
		echo "Waiting..."
		sleep 1
	done

	echo "Securing MariaDB..."
	# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param
	mariadb -e "DROP USER ''@'localhost'"
	mariadb -e "DROP USER ''@'$(hostname)'"
	mariadb -e "DROP DATABASE test"

	echo "Creating the database and a user..."
	mariadb -e "CREATE DATABASE ${MARIADB_DATABASE}"
	mariadb -e "CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}'"
	mariadb -e "GRANT ALL PRIVILEGES ON wordpress.* TO '${MARIADB_USER}'@'%'"
	mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}'"
	mariadb -e "FLUSH PRIVILEGES"

	echo "Restarting MariadB for changes..."
	sleep 1
	pkill -9 maria
else
	echo "MariaDB already installed."
fi
/usr/bin/mariadbd-safe --datadir=/var/lib/mysql
