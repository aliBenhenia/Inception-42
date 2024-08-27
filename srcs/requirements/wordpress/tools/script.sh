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
wp config create --allow-root --dbname=$MARIADB_DATABASE --dbuser=$WP_ADMIN_LOGIN --dbpass=$WP_ADMIN_PASSWORD --dbhost=$DB_HOST

# Install WordPress with the provided site information and admin credentials.
wp core install --allow-root --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_LOGIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL

# Create a new WordPress user with the specified details and role.
wp user create --allow-root $WP_USER_LOGIN $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=$WP_USER_ROLE

# Stop the PHP-FPM service.
service php7.4-fpm stop

# Start PHP-FPM in the foreground to keep the container running.
php-fpm7.4 -F
