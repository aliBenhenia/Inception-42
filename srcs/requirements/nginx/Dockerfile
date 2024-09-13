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


# not :openssl req -x509:

#     Purpose: Creates a self-signed certificate.
#     Reason: You need a certificate to enable HTTPS on your website.
#     -nodes:
    
#     Purpose: Stands for "no DES," meaning the private key will not be password-protected.
#     Reason: Simplifies automated processes since no passphrase is required to use the key.
#     -out /etc/nginx/ssl_cer.crt:
    
#     Purpose: Specifies where to save the certificate file.
#     Reason: You need to store the certificate so that the web server can use it to enable HTTPS.
#     -keyout /etc/nginx/ssl_cer_key.key:
    
#     Purpose: Specifies where to save the private key file.
#     Reason: The private key is used to decrypt data sent to your server. It must be kept secure and is needed alongside the certificate.
#     -subj "/C=Ma/L=khouribga/CN=abenheni/UID=abenheni":
    
#     Purpose: Sets information about the certificate, like Country (C), Location (L), Common Name (CN), and User ID (UID).
#     Reason: Provides identity details for the certificate, which is helpful for users to verify the certificate’s legitimacy.


# doc2 :
#     Example: Secure Communication Between a Client and a Server
# 1. Client Requests Secure Connection
# Client: A web browser (e.g., Chrome) wants to connect to a secure website (e.g., https://example.com).
# 2. Server Responds with Certificate
# Server: example.com has an SSL certificate that includes its public key.
# Server’s Certificate:
# Public Key: Part of the SSL certificate, shared openly.
# 3. SSL/TLS Handshake
# Client Receives Certificate:

# Action: The client receives the server’s SSL certificate, which contains the public key.
# Client Creates Session Key:

# Session Key: A temporary symmetric key used for encrypting the actual data.
# Example: Session key might be ABCD1234.
# Client Encrypts Session Key:

# Encryption: The client encrypts the session key with the server’s public key from the certificate.
# Action: This encrypted session key is sent to the server.
# Server Decrypts Session Key:

# Decryption: The server uses its private key to decrypt the session key.
# Result: Both the client and server now have the same session key.
# 4. Secure Data Exchange
# Client Sends Encrypted Data:

# Encryption: The client encrypts the data (e.g., a credit card number) using the session key.
# Example Data: Credit Card Number: 1234-5678-9876-5432
# Encrypted Data: Suppose this data encrypts to XyZ987....
# Server Receives and Decrypts Data:

# Decryption: The server decrypts the encrypted data using the session key.
# Result: The server retrieves the original data, e.g., 1234-5678-9876-5432.
# Summary of Keys and Encryption
# Public Key (Server’s): Used by the client to encrypt the session key (shared openly).
# Private Key (Server’s): Used by the server to decrypt the session key (kept secret).
# Session Key: Used by both the client and server to encrypt and decrypt the actual data exchanged during the session.
# This process ensures that even if someone intercepts the data being transmitted, they would not be able to read or alter it without the session key, which is securely exchanged using the public-private key pair.