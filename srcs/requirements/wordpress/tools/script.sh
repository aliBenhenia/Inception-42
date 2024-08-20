#!/bin/bash

# Create directories for WordPress
mkdir -p /var/www/html
cd /var/www/html

# Clean up any existing files (optional, depending on your needs)
rm -rf *

# Download and set up wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Download WordPress core
wp core download --allow-root

# Check if wp-config.php exists and handle it accordingly
if [ -f /var/www/html/wp-config.php ]; then
    mv /var/www/html/wp-config.php /var/www/html/wp-config-original.php
else
    # Create a new wp-config.php if it does not exist
    wp config create \
        --dbname="$WP_DB_NAME" \
        --dbuser="$WP_DB_USER" \
        --dbpass="$WP_DB_PASSWORD" \
        --dbhost="$WP_DB_HOST" \
        --allow-root
fi

# Install WordPress using wp-cli
wp core install \
    --url="$DOMAIN_NAME" \
    --title="$WP_SITE_TITLE" \
    --admin_user="$WP_ADMIN_USERNAME" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --skip-email \
    --allow-root

# Create additional WordPress user with specified role
wp user create "$WP_USER" "$WP_USER_EMAIL" \
    --role=author \
    --user_pass="$WP_USER_PASSWORD" \
    --allow-root

# Install and activate a WordPress theme
wp theme install astra --activate --allow-root

# Install and activate a WordPress plugin (example: Redis Object Cache)
wp plugin install redis-cache --activate --allow-root

# Update all installed plugins
wp plugin update --all --allow-root

# Configure PHP-FPM to listen on port 9000
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

# Create directory for PHP-FPM to run
mkdir -p /run/php

# Enable Redis caching for WordPress (if needed)
wp redis enable --allow-root

# Start PHP-FPM in foreground
/usr/sbin/php-fpm7.3 -F
