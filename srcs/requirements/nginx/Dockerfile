FROM debian:buster

RUN apt-get update && apt-get install -y nginx && apt-get install openssl -y


COPY ./tools/script.sh /

CMD ["/script.sh"]