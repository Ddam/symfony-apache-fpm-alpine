FROM php:7.2-fpm-alpine

LABEL maintainer="Derivery Damien <damien.derivery@gmail.com>"

ENV COMPOSER_VERSION 1.6.5

# Install necessary libraries
RUN apk --update add --no-cache --virtual .persistent-deps icu-dev gettext-dev libpng-dev zip unzip git bash \
    && rm -f /var/cache/apk/*
RUN if [ "$CONTAINER_ENV" = "build" -o "$CONTAINER_ENV" = "dev" ] ; then apk add --no-cache --virtual .persistent-deps vim ; fi

# Install necessary php extensions
RUN docker-php-ext-install gettext bcmath intl json gd zip pdo_mysql

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

# Use the new entrypoint
ENTRYPOINT ["entrypoint"]

CMD ["php-fpm"]
