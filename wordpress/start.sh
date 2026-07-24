#!/bin/sh
cd /var/www/html

set -e

wp core download --allow-root

wp   config create --dbname="${SQL_DATABASE}" \
                --dbuser="${SQL_USER}" \
                --dbpass="$(cat ../secrets/database_pass.txt)" \
                --dbhost="mariadb"


wp core install --url="https://mfahmi.42.fr" \
                --title="${WP_TITLE}" \
                --admin_user="${WP_ADMIN_USER}" \
                --admin_password="$(cat ../secrets/database_pass_root.txt)" \
                --admin_email="${WP_ADMIN_EMAIL}"

wp user create "${WP_USER}" "${WP_EMAIL}" \
    --role="${WP_ROLE}" \
    --user_pass="$(cat ../secrets/wp_pass.txt)"

exec php-fpm -F