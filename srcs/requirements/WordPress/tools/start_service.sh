#!/bin/sh

# Wait until mariadb is set
until mariadb-admin --host=mariadb ping; do
    sleep 5
done

# Configure WordPress if it isn't already set
if [ ! -f /var/www/html/wp-config.php ]; then
    cd  /var/www/html/
    if [ ! -f index.php ]; then
        wp-cli.phar core download
    fi
	wp-cli.phar config create   --dbname="$MARIADB_DATABASE" --dbuser="$MARIADB_USER" --dbpass="$MARIADB_PASSWORD" --dbhost=mariadb
	wp-cli.phar core install    --url="mhaouas.42.fr" --title="mhaouas-Inception" --admin_user="$ADMIN_USR" --admin_password="$ADMIN_PWD" --admin_email="$ADMIN_MAIL"
	wp-cli.phar user create     "$USER_USR" "$USER_MAIL" --role=author --user_pass="$USER_PWD"
    cd /
fi

# Start PhP
php-fpm82 -F