FROM alpine:3.7

LABEL maintainer="Derivery Damien <damien.derivery@gmail.com>"

# Install necessary libraries
RUN apk --update add --no-cache --virtual .persistent-deps mariadb mariadb-client \
    && apk add --no-cache tzdata \
    && rm -f /var/cache/apk/*

# comment out a few problematic configuration values
RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf && \
    # don't reverse lookup hostnames, they are usually another container
    sed -i '/^\[mysqld]$/a skip-host-cache\nskip-name-resolve' /etc/mysql/my.cnf && \
    # always run as user mysql
    sed -i '/^\[mysqld]$/a user=mysql' /etc/mysql/my.cnf && \
    # allow custom configurations
    echo -e '\n!includedir /etc/mysql/conf.d/' >> /etc/mysql/my.cnf && \
    mkdir -p /etc/mysql/conf.d/

COPY ./entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

ENTRYPOINT ["entrypoint"]

# Default arguments passed to ENTRYPOINT if no arguments are passed when starting container
CMD ["mysqld_safe"]
