#!/bin/bash

# if [ ! -e wp-config.php ]
# then
mariadb-install-db --datadir=/var/lib/mysql

# systemctl start mariadb
# mysql_secure_installation

chown -R mysql:mysql /var/lib/mysql/
chmod -R 750 /var/lib/mysql/

################################################################################
# LE SCRIPT DOIT S'ARRETER ICI POUR LE DEBUG
################################################################################

################## ETAPE 1, mode manuel, lancer mariadbd-safe ##################
## SUPPRIMER, pour l'instant cmd manuelle de -safe
sleep infinity
# /usr/bin/mariadbd-safe --datadir=/var/lib/mysql
# LANCER EN // 2 zsh
################################################################################

## SUPPRIMER, ne servira pas en prod car remplacé par les commandes SQL
mysql_secure_installation
################################################################################

# mariadb --password=1234
## set le mot de passe en dernier, pour eviter de devoir s'emmerder a le donner avant

# Make sure that NOBODY can access the server without a password
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '1234'"
# Kill the anonymous users
mariadb -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mariadb -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mariadb -e "DROP DATABASE test"
# Make our changes take effect
mariadb -e "FLUSH PRIVILEGES"
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

# [ ] CREER l'USER
mariadb -e "CREATE USER 'nadia'@localhost IDENTIFIED BY '5678'"
# [ ] CREER DB wordpress
mariadb -e "CREATE DATABASE wordpress"
# [ ] Trouver un tuto pour lier Adminer avec le tout (aled)
# si ca fonctionne avec Adminer, cela fonctionnera avec WordPress

################################################################################
# Commandes SQL pour verifier
mariadb -e "SELECT HOST, USER, PASSWORD FROM mysql.user"
mariadb -e "SHOW DATABASES"
################################################################################



# # fi

# php-fpm8 -F

## supprimer
sleep infinity
