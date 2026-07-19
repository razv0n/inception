#!/bin/sh

set -e   #exit at the first error -e

su  -s /bin/sh  mysql -c "mysqld" &
until mysqladmin ping --silent; do
    sleep 1
done

mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS database;
CREATE USER IF NOT EXISTS 'user'@'%' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES
ON database.*
TO 'user'@'%';
EOF

mysqladmin shutdown
exec su -s /bin/sh mysql -c "mysqld"