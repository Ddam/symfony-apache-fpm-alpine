FROM httpd:2.4-alpine

LABEL maintainer="Derivery Damien <damien.derivery@gmail.com>"

ENV APACHE_LOG_DIR /var/log/apache2
COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf

WORKDIR /var/www/html
