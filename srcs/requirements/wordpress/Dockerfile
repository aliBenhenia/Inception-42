FROM debian:11

# Update and install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    mariadb-client \
    php \
    php-mysql \
    php-fpm \
    wget

# Download and set up wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

# Ensure the PHP-FPM configuration directory exists
RUN mkdir -p /etc/php/7.4/fpm/pool.d

# Configure PHP-FPM to listen on port 9000
RUN echo "listen = 0.0.0.0:9000" >> /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

# Copy the script to the container
COPY tools/script.sh /script.sh
RUN chmod +x /script.sh

# Use CMD to specify the default command
CMD ["/script.sh"]
