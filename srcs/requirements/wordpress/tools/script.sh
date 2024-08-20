#!/bin/sh

# Sleep for 10 seconds to ensure services are up
sleep 10

# Start PHP-FPM service
service php7.4-fpm start

# Prepare WordPress files
mkdir -p /var/www/html
cd /var/www/html

# Print environment variables for debugging
echo "Database Host: $DB_HOST"
echo "Database Name: $MARIADB_DATABASE"
echo "Database User: $WP_ADMIN_LOGIN"

# Wait for the database to be ready (use a loop if needed)
until mysqladmin ping -h"$DB_HOST" --silent; do
  echo "Waiting for database connection..."
  sleep 5
done

# Download WordPress and configure it
wp core download --allow-root
wp config create --allow-root --dbname="$MARIADB_DATABASE" --dbuser="$WP_ADMIN_LOGIN" --dbpass="$WP_ADMIN_PASSWORD" --dbhost="$DB_HOST"
wp core install --allow-root --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_LOGIN" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL"

# Create a new WordPress user
wp user create --allow-root "$WP_USER_LOGIN" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD" --role="$WP_USER_ROLE"

# Stop PHP-FPM service to switch to foreground mode
service php7.4-fpm stop

# Start PHP-FPM in the foreground
php-fpm7.4 -F
