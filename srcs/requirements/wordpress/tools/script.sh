#!/bin/sh

# Sleep for a while to wait for MariaDB to be ready
sleep 10

# WordPress Configuration Variables
WP_SITE_TITLE="RiadElYacoute"
WP_ADMIN_USERNAME="forstman1"
WP_ADMIN_PASSWORD="1234"
WP_ADMIN_EMAIL="abenheni@example.com"
WP_USER="julia"
WP_USER_EMAIL="abenheni@1337.com"
WP_USER_PASSWORD="1233333"
WP_DB_NAME="maraidb_name"
WP_DB_USER="ss"
WP_DB_PASSWORD="tt"
WP_DB_HOST="mariadb"  # Update to your actual MariaDB service name

# MySQL Setup Variables
DB_NAME="maraidb_name"
DB_USER="ali"
DB_PASS="123ali"  # Update DB_PASS to match the MySQL user password
DB_ROOT_PASS="123"

# Display the MySQL variables
echo "DB_ROOT_PASS: $DB_ROOT_PASS"
echo "DB_NAME: $DB_NAME"
echo "DB_USER: $DB_USER"
echo "DB_PASS: $DB_PASS"

# Start PHP-FPM service
service php7.4-fpm start

# Create the WordPress directory and change to it
mkdir -p /var/www/html
cd /var/www/html

# Download and configure WordPress
wp core download --allow-root
wp config create --allow-root --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --dbhost="$WP_DB_HOST"

# Wait for the MariaDB service to be ready
until mysqladmin ping -h "$WP_DB_HOST" -u "$WP_DB_USER" -p"$WP_DB_PASSWORD" --silent; do
  echo "Waiting for database connection..."
  sleep 5
done

# Install WordPress
WP_URL="http://localhost"  # Define the URL for your WordPress site
wp core install --allow-root --url="$WP_URL" --title="$WP_SITE_TITLE" --admin_user="$WP_ADMIN_USERNAME" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL"
wp user create --allow-root "$WP_USER" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD" --role=subscriber

# Stop PHP-FPM service
service php7.4-fpm stop

# Start PHP-FPM in the foreground
php-fpm7.4 -F
