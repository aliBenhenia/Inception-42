#!/bin/sh

# Wait for 10 seconds to allow other services or dependencies to start up.
sleep 10

# Start PHP-FPM service.
service php7.4-fpm start

# Prepare the WordPress installation directory.
mkdir -p /var/www/html
cd /var/www/html

# Download the latest version of WordPress.
wp core download --allow-root

# Create the WordPress configuration file using the specified database credentials.
wp config create --allow-root --dbname=$DB_NAME --dbuser=$ADMIN_USERNAME --dbpass=$ADMIN_USERNAME --dbhost=$DB_CONNECTION_HOST

# Install WordPress with the provided site information and admin credentials.
wp core install --allow-root --url=$SITE_URL --title=$SITE_TITLE --admin_user=$ADMIN_USERNAME --admin_password=$ADMIN_USERNAME --admin_email=$ADMIN_EMAIL

# Create a new WordPress user with the specified details and role.
wp user create --allow-root $USER_USERNAME $USER_EMAIL --user_pass=$USER_PASSWORD --role=$USER_ROLE

# Stop the PHP-FPM service.
service php7.4-fpm stop

# Start PHP-FPM in the foreground to keep the container running.
php-fpm7.4 -F
