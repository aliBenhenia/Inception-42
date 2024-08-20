FROM debian:buster

# Update the package list and install necessary packages
RUN apt update && \
    apt install -y php-fpm php-mysql curl

# Copy the script.sh and wp-config.php files to the container
COPY ./tools/script.sh /script.sh
COPY ./tools/wp-config.php /var/www/html/wp-config.php

# Ensure the script is executable
RUN chmod +x /script.sh

# Set the script.sh file as the command to run when the container starts
CMD [ "/script.sh" ]
