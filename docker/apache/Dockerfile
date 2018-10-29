ARG APACHE_DOCKER_VERSION

FROM httpd:2.4-alpine

LABEL maintainer="Derivery Damien <damien.derivery@zephyr-web.fr>"

# Install necessary libraries
RUN apk --update add --no-cache --virtual .persistent-deps ca-certificates openssl acl \
    && rm -f /var/cache/apk/*

# Apache Conf
COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./httpd-ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf
COPY ./ssl /etc/ssl

COPY ./entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

WORKDIR /var/www/html

RUN mkdir public && touch public/index.html

EXPOSE 80 443

ENTRYPOINT ["entrypoint"]

CMD ["httpd-foreground"]
