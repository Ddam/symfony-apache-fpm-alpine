FROM node:10.5-alpine

LABEL maintainer="Derivery Damien <damien.derivery@gmail.com>"

RUN apk --update add --no-cache --virtual .persistent-deps make gcc g++ libc-dev libpng-dev bash \
    && rm -f /var/cache/apk/*

RUN npm install -g pngquant-bin --unsafe-perm=true --allow-root

COPY entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

WORKDIR /app

EXPOSE 8080

ENTRYPOINT ["entrypoint"]

CMD ["/app/node_modules/.bin/webpack-dev-server", "--hot", "--env.dev"]
