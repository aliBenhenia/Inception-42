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


# Wakhxa a sidi, ghadi nchr7 lik kolchi b tafsil:

#     1. SSL Certificate:
#     SSL Certificate howa bhal chi carta d'identité électronique dyal website. Kaytakhdam bach:
#     - Y'akked l visitors blli l website li daykhlou lih howa fعlan li homa baghyin
#     - Ychffer (encrypt) l ma3lomat li kaytbadlou bin l visitor w l website
    
#     2. OpenSSL Command:
#     Daba ghadi nchr7 lik l command li kayn f Dockerfile:
    
#     ```
#     RUN openssl req -x509 -nodes -out /etc/nginx/ssl_cer.crt -keyout /etc/nginx/ssl_cer_key.key -subj "/C=Ma/L=khouribga/CN=abenheni/UID=abenheni"
#     ```
    
#     - `openssl`: Hada howa l barnamij li kaysn3 w kaydir l SSL certificates
#     - `req`: Kay3ni "request", hna katlob mn OpenSSL ysn3 lik certificate
#     - `-x509`: Hada kay7ded no3 d certificate (X.509 howa standard international)
#     - `-nodes`: Kay3ni "No DES", ya3ni l private key ma ghadich tkoun mchiffra b password
#     - `-out /etc/nginx/ssl_cer.crt`: Fin ghadi yt7t l certificate
#     - `-keyout /etc/nginx/ssl_cer_key.key`: Fin ghadi yt7t l private key
#     - `-subj "..."`: Hna katعti l ma3lomat li ghadi ykounou f certificate:
#       - `/C=Ma`: Country = Morocco
#       - `/L=khouribga`: Location = Khouribga
#       - `/CN=abenheni`: Common Name = abenheni
#       - `/UID=abenheni`: User ID = abenheni
    
#     3. NGINX:
#     NGINX howa web server, kay9dr ykhdem ka:
#     - Web server: Kayservi l pages web
#     - Reverse proxy: Kay7mi l application dyalk w kaynddm l traffic
#     - Load balancer: Kaywzz3 l traffic 3la bzaf d servers
    
#     4. Dockerfile Commands:
#     - `FROM debian:11`: Kaybda l image b Debian 11 ka base
#     - `RUN apt update && apt upgrade -y && apt install -y nginx openssl`: Kay7ddt l system w kayinstalli NGINX w OpenSSL
#     - `COPY conf/nginx.conf /etc/nginx/nginx.conf`: Kaykopyi l configuration file dyal NGINX l blasto f container
#     - `EXPOSE 443`: Kay3ln blli l container ghadi yft7 port 443 (port dyal HTTPS)
#     - `CMD ["nginx", "-g", "daemon off;"]`: Kaykhddm NGINX f l'avant-plan mlli kaykhdem l container
    
#     5. HTTPS:
#     HTTPS howa version sécurisée dyal HTTP. Kaystعml SSL/TLS bach ychiffr l communication bin l browser w l server. Hada kay7mi l ma3lomat mn ttna9ol b chkl mfhom wla tbddl.
    
#     6. Public Key w Private Key:
#     - Public Key: Bhal mfta7 li kol wa7d y9dr ychouf, walakin ma y9drch y7l bih. Kaytkhdam bach tchiffr l ma3lomat.
#     - Private Key: Mfta7 sirri, ghir l malik dyalo li 3ndo. Kaytkhdam bach t7l l ma3lomat li tchiffrat b public key.
    
#     Hadchi kaml kaykhdm m3a b3do bach y7mi l communication dyalk f l'internet w y'akkd l'identité dyal websites li katzor.











#     Mzyan, ghadi nchr7 lik chno kaykoun f SSL certificate:

#         1. Informations 3la l-malik:
#            - Common Name (CN): Smiya dyal website (bhal www.example.com)
#            - Organization (O): Smiya dyal chrika wla mo2assasa
#            - Organizational Unit (OU): Sm l-9ism f chrika (optional)
#            - Country (C): Rmz l-blad (bhal MA l-Morocco)
#            - State/Province (ST): Sm l-ji7a
#            - Locality (L): Mdina
        
#         2. Ma3lomat t9niya:
#            - Public Key: Mfta7 3am li kayst3ml bach ychiffr l-ma3lomat
#            - Serial Number: R9m unique dyal had certificate
#            - Version: Version dyal X.509 standard li mst3ml
#            - Signature Algorithm: No3 d-algorithm li tst3ml bach ysigni certificate (bhal SHA-256)
        
#         3. Dates:
#            - Not Before: Tarikh mn fin certificate wlla valid
#            - Not After: Tarikh fin ghadi ysali certificate (expiration date)
        
#         4. Issuer Information:
#            - Ma3lomat 3la l-jiha li darat certificate (Certificate Authority)
        
#         5. Extensions:
#            - Subject Alternative Name (SAN): Smiyat okhra li certificate valid 3lihom (bhal www.example.com w example.com)
#            - Key Usage: Chno msmou7 tdir b had certificate (bhal digital signature, key encipherment)
#            - Extended Key Usage: Tkhssisat zayda (bhal TLS Web Server Authentication)
        
#         6. Fingerprints:
#            - Hash values dyal certificate (bhal SHA-1 fingerprint)
        
#         7. Signature:
#            - Signature r9miya dyal Certificate Authority li kat2kkd s77a dyal certificate
        
#         Had l-ma3lomat kaml katjm3 bach t3ti wa7d l-hawiya r9miya l website. Mlli browser kaychof had certificate, kay9dr yt2kkd mn identity dyal website w y3rf wach communication ghadi tkoun mchiffra w amina.
        
#         Mohim tعrf blli f self-signed certificate (bhal li drna f Dockerfile), bzaf mn had l-ma3lomat katкoun basic wla ma kaynach, 7it nta li katsn3o b rassk, machi chi Certificate Authority m3roufa.\



















#         Mzyan, ghadi n3tik mital mfssl kifach kaykhdem had certificate:

#             Tkhayyl blli 3ndk website smito "www.matjri.ma" w bghiti tkhddmo b HTTPS. Ha kifach ghadi tmchi l3maliya:
            
#             1. Preparation:
#                - Katsn3 SSL certificate dyalk (ima self-signed wla katjibo mn Certificate Authority).
#                - Katconfiguri server dyalk (NGINX f halat dyalna) bach yst3ml had certificate.
            
#             2. Ziyarat l-website:
#                Wa7d z-zboun (Sarah) bgha tzor www.matjri.ma
            
#             3. Connection:
#                - Sarah katktb www.matjri.ma f browser dyalha.
#                - Browser kay7awl ytassl b server dyalk 3la port 443 (HTTPS).
            
#             4. SSL Handshake:
#                a. Server dyalk kaybda kayرسل certificate l browser dyal Sarah.
#                b. Browser kayشوف l-certificate:
#                   - Kay9ra Common Name: www.matjri.ma
#                   - Kay9ra Issuer: Certificate Authority li snع3at certificate (ila kan m3trف biha)
#                   - Kay9ra Expiration Date: Kay2kkd mazal sal7
#                c. Browser kayvérifier signature dyal certificate b public key dyal Certificate Authority.
#                d. Ila kolchi mzyan, browser kay9bl certificate w kaygeneri wa7d "session key".
#                e. Browser kaychiffr had session key b public key li lقاها f certificate.
#                f. Browser kayصيفط had session key mchiffra l server dyalk.
#                g. Server dyalk kay7l had session key b private key dyalo.
            
#             5. Secure Connection:
#                - Daba Sarah w server 3ndhom nfs session key.
#                - Ay 7aja Sarah ghadi tktb f site (bhal login, card bancaire, etc.) ghadi tchiffr b had session key.
#                - Server kay9dr y7l had encryption b nfs session key.
            
#             6. Visual Indicators:
#                - Browser dyal Sarah ghadi ywerriha icon dyal 9fل khдr w/wla "https://" f address bar.
#                - Ila clickat 3la had icon, ghadi tchof tafasil dyal certificate dyalk.
            
#             7. End of Session:
#                - Mlli Sarah katsdd browser wla katkhrej mn site, session key kayttlف.
#                - L-marra jaya li ghadi tzor, ghadi tبدا process jdida.
            
#             Hadchi kaml kayтم f جزء mn tanya, w kaykhdm 3la kol connection l site dyalk. Certificate kayساهم f:
#             1. Authentication: Kay2kkd l Sarah blli hiya f3lan kat7der m3a www.matjri.ma
#             2. Encryption: Kay7mi l-ma3lomat dyalha mn ttنصت wla تغيير
#             3. Integrity: Kay2kkd blli l-ma3lomat ma tbddlatch bin Sarah w server
            
#             Hakka, 7ta ila chi 7d عترض l-communication, ma ghadi y9drch y9ra wla ybddl l-ma3lomat li kayttbadl.