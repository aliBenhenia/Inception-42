# Use the official Debian 11 image as the base image.
FROM debian:11

# Update the package lists, upgrade installed packages, and install MariaDB client,
# PHP, PHP MySQL extension, PHP-FPM, and wget.
RUN apt -y update && apt -y upgrade && apt -y install mariadb-client php php-mysql php-fpm wget

# Download the WP-CLI tool, which is a command-line interface for managing WordPress installations.
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Move the WP-CLI binary to /usr/local/bin and rename it to 'wp'.
RUN mv wp-cli.phar /usr/local/bin/wp

# Make the WP-CLI tool executable.
RUN chmod +x /usr/local/bin/wp

# Configure PHP-FPM to listen on all network interfaces on port 9000.
RUN echo "listen=0.0.0.0:9000" >> /etc/php/7.4/fpm/pool.d/www.conf

# Expose port 9000 so that it can be accessed from outside the container.
EXPOSE 9000

# Copy the custom script (script.sh) from the local directory to the root directory in the container.
COPY tools/script.sh /

# Make the script executable.
RUN chmod +x /script.sh

# Set the script as the entry point, so it will be executed when the container starts.
ENTRYPOINT ["./script.sh"]
