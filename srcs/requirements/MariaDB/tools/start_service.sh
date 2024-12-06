#!/bin/sh

mariadb-install-db

service mariadb start;

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;"

mariadb -e "CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"

mariadb -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO \`${MARIADB_USER}\`@'%' ;"

mariadb -e "FLUSH PRIVILEGES;"

mariadb-admin -u root shutdown

exec mariadbd-safe
