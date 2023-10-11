#!/bin/sh

# debogage mode
# set -xv

# [1] demarrage de mariadb
service mariadb start

# [2] modification du mdp de l'utilisateur root
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL__ROOT_PASS';"

# [3] cree une base de donnee
mysql -u root -p"$MYSQL__ROOT_PASS" -e "CREATE DATABASE IF NOT EXISTS $MYSQL__DB_NAME;"

# [4] cree un utilisateur
mysql -u root -p"$MYSQL__ROOT_PASS" -e "CREATE USER IF NOT EXISTS '$MYSQL__DB_USER'@'%' IDENTIFIED BY '$MYSQL__DB_PASSWORD';"

# [5] lui donne tous les droits sur la base de donnee
mysql -u root -p"$MYSQL__ROOT_PASS" -e "GRANT ALL PRIVILEGES ON $MYSQL__DB_NAME.* TO '$MYSQL__DB_USER'@'%' WITH GRANT OPTION;"

# [6] actualise les privilege dans mariadb
mysql -u root -p"$MYSQL__ROOT_PASS" -e "FLUSH PRIVILEGES;"

# [7] arret de mariadb
mysqladmin -u root -p"$MYSQL__ROOT_PASS" shutdown

# [8] retour vers le Dockerfile jusqu'a utilisation de CMD
exec "$@"


# Reprise des etape du script d'installation officiel : 
# mysql_secure_installation
# source https://mariadb.com/kb/en/mysql_secure_installation/

# mysql_secure_installation is a shell script available 
# on Unix systems, and enables you to improve the security
# of your MariaDB installation in the following ways:

#  -> You can set a password for root accounts.
#  -> You can remove root accounts that are accessible 
#     from outside the local host.
#  -> You can remove anonymous-user accounts.
#  -> You can remove the test database, which by default
#     can be accessed by anonymous users. 