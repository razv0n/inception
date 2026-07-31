#!/bin/sh
set -e

cd /var/www/html

until mysqladmin ping -h mariadb --silent; do
    sleep 1
done
if [ ! -f wp-config.php ]; then
    if [ ! -f wp-load.php ]; then
        wp core download --allow-root
    fi
    wp  config create --dbname="${SQL_DATABASE}" \
                   --dbuser="${SQL_USER}" \
                    --dbpass="$(cat /run/secrets/database_pass)" \
                    --dbhost="mariadb"\
                    --allow-root    

    wp core install --url="https://mfahmi.42.fr" \
                    --title="${WP_TITLE}" \
                    --admin_user="${WP_ROOT_USER}" \
                    --admin_password="$(cat /run/secrets/wp_pass_root)" \
                    --admin_email="${WP_ADMIN_EMAIL}"\
                    --allow-root

    wp user create "${WP_USER}" "${WP_EMAIL}" \
        --role="${WP_ROLE}" \
        --user_pass="$(cat  /run/secrets/wp_pass)"\
        --allow-root
fi
exec php-fpm8.2 -F

#if condition check,  what is mysqladmin   
#php-mysql is the PHP database driver (extension) that implements the MySQL/MariaDB client protocol.