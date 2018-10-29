#!/bin/sh
set -e

if [ ${CONTAINER_ENV} = dev ]; then
    cd /var/www/html

    if [ -e /var/www/html/composer.json ]; then
        # Composer
        if [ -d /var/www/html/vendor/ ]; then
            composer update --no-suggest --no-progress
        else
            composer install --no-suggest --no-progress
        fi;
    fi;

    echo 'Dev mode'
elif [ ${CONTAINER_ENV} = prod ]; then
    echo 'Prod mode'
fi;

# Permissions settings
echo 'Permissions settings'
chown -R www-data:www-data var public

exec "$@"
