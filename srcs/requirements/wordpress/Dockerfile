FROM debian:buster

RUN apt update &&  apt install -y  php-fpm  php-mysql 

COPY ./tools/script.sh /
COPY ./tools/wp-config.php /

CMD [ "/script.sh" ]
