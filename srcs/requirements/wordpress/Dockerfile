# Use an official WordPress image as base
FROM wordpress:latest

# Set the working directory inside the container
WORKDIR /var/www/html

# Copy the contents of the current directory to the working directory inside the container
COPY . .

# Set up permissions (optional, adjust as necessary)
RUN chown -R www-data:www-data /var/www/html

# Expose port 80 to the Docker host, so we can access the container from the outside
EXPOSE 80

# Default command to run when the container starts
CMD ["apache2-foreground"]
