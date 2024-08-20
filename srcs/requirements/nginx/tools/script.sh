#!/bin/bash

# Variables
CERTS_PATH="/etc/ssl/certs/nginx-selfsigned.crt"
KEY_PATH="/etc/ssl/private/nginx-selfsigned.key"
DOMAIN_NAME="${DOMAIN_NAME:-localhost}"

# Generate a self-signed SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$KEY_PATH" -out "$CERTS_PATH" \
    -subj "/C=MO/L=KH/O=1337/OU=student/CN=$DOMAIN_NAME"

# Create or overwrite the Nginx server block configuration
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name $DOMAIN_NAME;

    ssl_certificate $CERTS_PATH;
    ssl_certificate_key $KEY_PATH;
    ssl_protocols TLSv1.3;

    index index.php;
    root /var/www/html;

    location ~ \.php$ {
        try_files \$uri =404;
        fastcgi_pass wordpress:9000;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# Reload Nginx to apply the changes
nginx -s reload || nginx -g "daemon off;"
