#!/bin/sh

# Sleep for a while to wait for MariaDB to be ready
sleep 20  # Increase if necessary to ensure MariaDB is fully ready

# WordPress Configuration Variables
WP_SITE_TITLE="RiadElYacoute"
WP_ADMIN_USERNAME="forstman1"
WP_ADMIN_PASSWORD="1234"
WP_ADMIN_EMAIL="abenheni@example.com"
WP_USER="julia"
WP_USER_EMAIL="abenheni@1337.com"
WP_USER_PASSWORD="1233333"
WP_DB_NAME="maraidb_name"
WP_DB_USER="ali"  # Ensure this matches the MariaDB user
WP_DB_PASSWORD="123"  # Ensure this matches the MariaDB user's password
WP_DB_HOST="mariadb"  # Use the correct service name for MariaDB

# Display the WordPress variables
echo "-> WP_SITE_TITLE: $WP_SITE_TITLE"
echo "-> WP_ADMIN_USERNAME: $WP_ADMIN_USERNAME"
echo "-> WP_DB_NAME: $WP_DB_NAME"
echo "-> WP_DB_USER: $WP_DB_USER"
echo "-> WP_DB_PASSWORD: $WP_DB_PASSWORD"

# Start PHP-FPM service
service php7.4-fpm start

# Create the WordPress directory and change to it
mkdir -p /var/www/html
cd /var/www/html

# Download and configure WordPress
wp core download --allow-root
wp config create --allow-root --dbname="$WP_DB_NAME" --dbuser="$WP_DB_USER" --dbpass="$WP_DB_PASSWORD" --dbhost="$WP_DB_HOST"

# Wait for the MariaDB service to be ready
until mysqladmin ping -h "$WP_DB_HOST" -u "$WP_DB_USER" -p"$WP_DB_PASSWORD" --silent; do
  echo "Waiting for database connection..."
  sleep 5
done

# Install WordPress
WP_URL="http://localhost"  # Update as needed
wp core install --allow-root --url="$WP_URL" --title="$WP_SITE_TITLE" --admin_user="$WP_ADMIN_USERNAME" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL"
wp user create --allow-root "$WP_USER" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD" --role=subscriber

# Stop PHP-FPM service
service php7.4-fpm stop

# Start PHP-FPM in the foreground
php-fpm7.4 -F
