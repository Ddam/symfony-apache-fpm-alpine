FROM php:7.2-fpm-alpine

LABEL maintainer="Derivery Damien <damien.derivery@gmail.com>"

ENV COMPOSER_VERSION 1.6.5

# Install necessary libraries
RUN apk --update add --no-cache --virtual .persistent-deps libintl icu icu-dev libxml2-dev libpng-dev bash \
    && apk --no-cache add --virtual .phpize-deps $PHPIZE_DEPS; \
        pecl install mongodb; \
        docker-php-ext-enable mongodb ; \
        apk del .phpize-deps \
    && rm -f /var/cache/apk/*
RUN if [ "$CONTAINER_ENV" = "build" -o "$CONTAINER_ENV" = "dev" ] ; then apk add --no-cache --virtual .persistent-deps vim ; fi

# Install necessary php extensions
RUN docker-php-ext-install bcmath intl gd zip

RUN curl -s -f -L -o /tmp/installer.php https://raw.githubusercontent.com/composer/getcomposer.org/b107d959a5924af895807021fcef4ffec5a76aa9/web/installer \
    && php -r " \
        \$signature = '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061'; \
        \$hash = hash('SHA384', file_get_contents('/tmp/installer.php')); \
        if (!hash_equals(\$signature, \$hash)) { \
            unlink('/tmp/installer.php'); \
            echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
            exit(1); \
        }" \
    && php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} \
    && composer --ansi --version --no-interaction \
    && rm -rf /tmp/* /tmp/.htaccess

RUN mkdir -p /run/php

COPY ./entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

WORKDIR /var/www/html

#RUN curl -L -u "${BITBUCKET_USER}:${BITBUCKET_PASSWORD}" "${BITBUCKET_REPOSITORY_URL}/get/${APP_VERSION}.tar.gz" -o /var/www/html/archive.tar.gz \
#    && tar -zxvf /var/www/html/archive.tar.gz --strip 1 -C /var/www/html \
#    && rm -rf /var/www/html/archive.tar.gz

# Use the new entrypoint
ENTRYPOINT ["entrypoint"]

CMD ["php-fpm"]
