#!/bin/bash

# 1. Start MariaDB service
service mariadb start

# Wait for 5 seconds to ensure MariaDB has started properly
sleep 4

# 2. Configure MariaDB
# Set the root password
mysqladmin -u root password "$DB_ADMIN_PASSWORD"

# Create the specified database if it does not already exist
mysql -u root -p"$DB_ADMIN_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Create a new user with the specified password if it does not already exist
mysql -u root -p"$DB_ADMIN_PASSWORD" -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"

# Grant all privileges on the specified database to the new user
mysql -u root -p"$DB_ADMIN_PASSWORD" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"

# Apply the privilege changes
mysql -u root -p"$DB_ADMIN_PASSWORD" -e "FLUSH PRIVILEGES;"

# 3. Stop the MariaDB service
service mariadb stop

# Start the MariaDB server in safe mode, allowing it to accept connections from any IP address
# Bind address is set to 0.0.0.0 to accept connections from any network interface
mysqld_safe --port=3306 --bind-address=0.0.0.0
