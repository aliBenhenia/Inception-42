
FROM debian:bullseye


RUN apt -y update && apt -y upgrade && apt -y install mariadb-client php php-mysql php-fpm wget

 
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar


RUN mv wp-cli.phar /usr/local/bin/wp

 
RUN chmod +x /usr/local/bin/wp

  
RUN echo "listen=0.0.0.0:9000" >> /etc/php/7.4/fpm/pool.d/www.conf

  
EXPOSE 9000

 
COPY tools/script.sh /

 
RUN chmod +x /script.sh

 
ENTRYPOINT ["./script.sh"]
