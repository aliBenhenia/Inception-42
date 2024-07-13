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

# Copy wp-config.php provided in the Docker build context
mv /var/www/html/wp-config.php /var/www/html/wp-config-original.php

# Set up wp-config.php with environment variables
sed -i "s/database_name_here/$DB_NAME/g" wp-config-original.php
sed -i "s/username_here/$DB_USER/g" wp-config-original.php
sed -i "s/password_here/$DB_PASSWORD/g" wp-config-original.php
mv wp-config-original.php wp-config.php

# Install WordPress using wp-cli
wp core install \
    --url="$DOMAIN_NAME" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
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
mkdir /run/php

# Enable Redis caching for WordPress (if needed)
wp redis enable --allow-root

# Start PHP-FPM in foreground
/usr/sbin/php-fpm7.3 -F
