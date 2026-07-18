FROM debian:bookworm
RUN apt update && apt install mariadb-server -y
CMD ["mysqld"]




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