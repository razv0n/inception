#!/bin/sh

set -e   #exit at the first error -e

su  -s /bin/sh  mysql -c "mysqld" &
until mysqladmin ping --silent; do
    sleep 1
done

mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '$(cat /secrets/database_pass.txt)';
GRANT ALL PRIVILEGES
ON ${SQL_DATABASE}.*
TO '${SQL_USER}'@'%';
EOF

mysqladmin shutdown
exec su -s /bin/sh mysql -c "mysqld"