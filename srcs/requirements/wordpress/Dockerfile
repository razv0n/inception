FROM debian:bookworm

RUN apt update && apt install -y php-fpm php php-mysql curl mariadb-client

RUN mkdir -p /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
                         && chmod +x wp-cli.phar \
                         && mv wp-cli.phar /usr/local/bin/wp

RUN sed -i 's|listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

COPY tools/start.sh /start.sh

RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]


#   ---reminder---
# WordPress PHP code

        # |
        # ▼

# PHP database library
# (mysqli / PDO)

        # |
        # ▼

# MySQL protocol
        # |
        # ▼

# MariaDB server


# WordPress (PHP code)
        # |
        # | calls mysqli/PDO functions
        # ▼
# mysqli / PDO
        # |
        # | sends SQL commands using MySQL protocol
        # ▼
# MariaDB
        # |
        # | executes SQL
        # ▼
# Data returned