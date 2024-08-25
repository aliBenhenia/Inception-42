#!/bin/bash

# MariaDB Configuration Variables
DB_NAME="maraidb_name"
DB_USER="ali"
DB_PASS="123"  # Ensure this matches the password in WordPress configuration
DB_ROOT_PASS="123"

# Display the MySQL variables
echo "DB_ROOT_PASS: $DB_ROOT_PASS"
echo "DB_NAME: $DB_NAME"
echo "DB_USER: $DB_USER"
echo "DB_PASS: $DB_PASS"

# Start MariaDB service
service mariadb start
sleep 5

# MariaDB Configuration
mysqladmin -u root password "$DB_ROOT_PASS"
mysql -u root -p"$DB_ROOT_PASS" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u root -p"$DB_ROOT_PASS" -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';"
mysql -u root -p"$DB_ROOT_PASS" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"
mysql -u root -p"$DB_ROOT_PASS" -e "FLUSH PRIVILEGES;"

# Optionally stop the service if you're starting mysqld_safe separately
service mariadb stop

# Start MySQL server daemon with specified configurations
mysqld_safe --port=3306 --bind-address=0.0.0.0
