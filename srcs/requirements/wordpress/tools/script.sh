#!/bin/sh

# Sleep for a while to wait for MariaDB to be ready
sleep 10

DB_NAME="maraidb_name"
DB_USER="your_username"
DB_PASS="your_password"
# Start PHP-FPM service
service php7.4-fpm start

# Create the WordPress directory and change to it
mkdir -p /var/www/html
cd /var/www/html

# Download and configure WordPress
wp core download --allow-root
wp config create --allow-root --dbname="$DB_NAME" --dbuser="$WP_DB_USER" --dbpass="$WP_DB_PASSWORD" --dbhost="$WP_DB_HOST" 

# Wait for the MariaDB service to be ready
until mysqladmin ping -h "$WP_DB_HOST" -u "$WP_DB_USER" -p"$WP_DB_PASSWORD" --silent; do
  echo "Waiting for database connection..."
  sleep 5
done

# Install WordPress
wp core install --allow-root --url="$WP_URL" --title="$WP_SITE_TITLE" --admin_user="$WP_ADMIN_USERNAME" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL"
wp user create --allow-root "$WP_USER" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD" --role=subscriber

# Stop PHP-FPM service
service php7.4-fpm stop

# Start PHP-FPM in the foreground
php-fpm7.4 -F
