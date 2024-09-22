events {
    # Configuration related to handling connections and events goes here.
    # This block is usually left empty unless specific event settings are needed.
}

http {
    server {
        # Listen on port 443 for HTTPS connections with SSL enabled.
        listen 443 ssl;
        
        # Define the server names for this virtual host. 
        # `www.$DOMAIN_NAME.42.fr` and `$DOMAIN_NAME.42.fr` are placeholders for the actual domain.
        server_name www.$DOMAIN_NAME.42.fr $DOMAIN_NAME.42.fr;

        # Specify the SSL certificate and key files for HTTPS.
        ssl_certificate /etc/nginx/ssl_cer.crt;
        ssl_certificate_key /etc/nginx/ssl_cer_key.key;

        # Set the SSL protocols to use.
        # In this case, only TLSv1.3 is enabled for enhanced security.
        ssl_protocols TLSv1.3;

        # Define the root directory for serving files and the default index files.
        root /var/www/html;
        index index.php index.html;

        # Handle requests for files and directories.
        # If a file or directory is not found, return a 404 error.
        location / {
            try_files $uri $uri/ =404;
        }

        # Handle PHP file requests.
        # Pass these requests to a FastCGI process running on port 9000.
        location ~ \.php$ {
            include fastcgi.conf;
            fastcgi_pass wordpress:9000; # Connects to the WordPress service on port 9000.
        }
    }
}

# test - sa --------------------------------------------
# Placeholder for additional configuration or comments.
