# Use the official Debian 11 image as the base image.
FROM debian:11

# Update the package lists, upgrade installed packages, and install NGINX and OpenSSL.
RUN apt update && apt upgrade -y && apt install -y nginx openssl

# Generate a self-signed SSL certificate and key for HTTPS.
# - `-x509` specifies the X.509 certificate format.
# - `-nodes` means "no DES", so the private key will not be encrypted.
# - `-out` specifies the output file for the certificate.
# - `-keyout` specifies the output file for the private key.
# - `-subj` specifies the subject field for the certificate.
RUN openssl req -x509 -nodes -out /etc/nginx/ssl_cer.crt -keyout /etc/nginx/ssl_cer_key.key -subj "/C=Ma/L=khouribga/CN=abenheni/UID=abenheni"

# Copy your custom NGINX configuration file into the container.
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Expose port 443 to allow HTTPS traffic to reach the container.
EXPOSE 443

# Start NGINX in the foreground (so it keeps running as the main process).
CMD ["nginx", "-g", "daemon off;"]
