# Use a specific tag for stability
FROM debian:11

# Install necessary packages and clean up to reduce image size
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y nginx openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Generate SSL certificate and key with appropriate permissions
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/ssl_cer_key.key \
    -out /etc/nginx/ssl/ssl_cer.crt \
    -subj "/C=MA/L=Khouribga/CN=abenheni/UID=abenheni" && \
    chmod 600 /etc/nginx/ssl/ssl_cer_key.key

# Copy the custom nginx configuration
COPY conf/default.conf /etc/nginx/default.conf

# Expose port 443 for HTTPS traffic
EXPOSE 443

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
