#!/bin/bash

# if [ ! -e wp-config.php ]
# then
mariadb-install-db --datadir=/var/lib/mysql

chown -R mysql:mysql /var/lib/mysql/
chmod -R 750 /var/lib/mysql/

################################################################################
# LE SCRIPT DOIT S'ARRETER ICI POUR LE DEBUG
################################################################################

################## ETAPE 1, mode manuel, lancer mariadbd-safe ##################
## SUPPRIMER, pour l'instant cmd manuelle de -safe
# sleep infinity
# /usr/bin/mariadbd-safe --datadir=/var/lib/mysql --nowatch
# LANCER EN // 2 zsh
################################################################################

#  Pour modifier et accepter les connexions en dehors du localhost
# sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
# sed -i "s|.*skip-networking.*|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

#relancer ensuite !
# pkill mariadb
/usr/bin/mariadbd-safe --datadir=/var/lib/mysql --nowatch

echo "after reboot post sed"

## SUPPRIMER, ne servira pas en prod car remplacé par les commandes SQL
# mysql_secure_installation
################################################################################

# mariadb --password=1234
## set le mot de passe en dernier, pour eviter de devoir s'emmerder a le donner avant

# Make sure that NOBODY can access the server without a password
# mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '1234'"
# Kill the anonymous users
sleep 5

mariadb -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mariadb -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mariadb -e "DROP DATABASE test"

# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

# [ ] CREER DB wordpress
mariadb -e "CREATE DATABASE wordpress"
# [ ] CREER l'USER
mariadb -e "CREATE USER 'nadia'@'%' IDENTIFIED BY '5678'"
# mariadb -e "CREATE USER 'julien'@localhost IDENTIFIED BY '1234'"
mariadb -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'nadia'@'%'"
# mariadb -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'julien'@'localhost'" --> sera le user pour WORDPRESS pas MARIADB
# [ ] Trouver un tuto pour lier Adminer avec le tout (aled)
# si ca fonctionne avec Adminer, cela fonctionnera avec WordPress
# Make our changes take effect
mariadb -e "FLUSH PRIVILEGES"
################################################################################
# Commandes SQL pour verifier
# mariadb -e "SELECT HOST, USER, PASSWORD FROM mysql.user"
# mariadb -e "SHOW DATABASES"
################################################################################




#pkill mariadb
#safe a nouveau ?

# # fi
sleep infinity

# php-fpm8 -F
