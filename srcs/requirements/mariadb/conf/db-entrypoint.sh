#!/bin/bash

# if [ ! -e wp-config.php ]
# then
mariadb-install-db --datadir=/var/lib/mysql

chown -R mysql:mysql /var/lib/mysql/
chmod -R 750 /var/lib/mysql/

/usr/bin/mariadbd-safe --datadir=/var/lib/mysql --nowatch

# mariadb --password=1234
## set le mot de passe en dernier, pour eviter de devoir s'emmerder a le donner avant

# Make sure that NOBODY can access the server without a password


# RETURN values examples: 0 OK | 2 unreachable
while ! mysqladmin --host=${WORDPRESS_DB_HOST} ping --silent;
do
sleep 1
done

mariadb -e "DROP USER ''@'localhost'"
mariadb -e "DROP USER ''@'$(hostname)'"
mariadb -e "DROP DATABASE test"

# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

mariadb -e "CREATE DATABASE wordpress"
mariadb -e "CREATE USER 'nadia'@'%' IDENTIFIED BY '5678'"
mariadb -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'nadia'@'%'"
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '1234'"
mariadb -e "FLUSH PRIVILEGES"

################################################################################
# Commandes SQL pour verifier
# mariadb -e "SELECT HOST, USER, PASSWORD FROM mysql.user"
# mariadb -e "SHOW DATABASES"
################################################################################



################################################################################
# SUPPRIMER, remplacer par une boucle qui attend
# sleep infinity
#### REMPLACER PAR
pkill maria
/usr/bin/mariadbd-safe --datadir=/var/lib/mysql
####
