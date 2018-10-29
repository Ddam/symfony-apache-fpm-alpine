FROM adminer:latest

LABEL maintainer="Derivery Damien <damien.derivery@gmail.com>"

USER root

# Install necessary libraries
RUN apk --no-cache add --virtual .phpize-deps $PHPIZE_DEPS; \
        pecl install mongodb; \
        docker-php-ext-enable mongodb ; \
        apk del .phpize-deps \
    && rm -f /var/cache/apk/*

USER adminer
CMD [ "php", "-S", "[::]:8080", "-t", "/var/www/html" ]
