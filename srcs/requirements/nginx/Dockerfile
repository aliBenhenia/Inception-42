
FROM debian:bullseye

  
RUN apt update && apt upgrade -y && apt install -y nginx openssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl_cer.crt -keyout /etc/nginx/ssl_cer_key.key -subj "/C=Ma/L=khouribga/CN=abenheni/UID=abenheni"

  
COPY conf/nginx.conf /etc/nginx/nginx.conf

  
EXPOSE 443

  
CMD ["nginx", "-g", "daemon off;"]

