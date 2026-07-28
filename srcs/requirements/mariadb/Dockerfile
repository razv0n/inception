FROM debian:bookworm

RUN apt update && apt install mariadb-server -y

RUN sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' \
    /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]




# Container starts
#         │
#         ▼
# 1. Start mysqld
#         │
#         ▼
# 2. Wait until MariaDB is accepting connections
#         │
#         ▼
# 3. Create database
#         │
#         ▼
# 4. Create WordPress user
        # │
        # ▼
# 5. Grant permissions
        # │
        # ▼
# 6. Keep mysqld running