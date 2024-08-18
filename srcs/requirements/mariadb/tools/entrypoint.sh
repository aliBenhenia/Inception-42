#!/bin/bash

# Variables
# DB_NAME="your_database_name"
# DB_USER="your_username"
# DB_PASS="your_password"

# SQL commands
SQL1="CREATE DATABASE IF NOT EXISTS $DB_NAME;"
SQL2="CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
SQL3="GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
SQL4="FLUSH PRIVILEGES;"

# Execute SQL commands
mysql -u root -p -e "$SQL1"
mysql -u root -p -e "$SQL2"
mysql -u root -p -e "$SQL3"
mysql -u root -p -e "$SQL4"

echo "Database '$DB_NAME' and user '$DB_USER' created with all privileges."
