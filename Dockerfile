FROM php:7.1-fpm-alpine

ENV BUILD_DEPS \
                zlib-dev \
                icu-dev \
                util-linux-dev \
                autoconf \
                g++ \
                gcc \
                make \
                pcre-dev

RUN apk update && apk add --no-cache --virtual .build-deps $BUILD_DEPS \
    && apk add bash icu-libs util-linux \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
    && docker-php-ext-install zip mbstring intl opcache bcmath \
    && pecl install xdebug \
    && pecl install apcu \
    && pecl install uuid \
    && docker-php-ext-enable xdebug apcu uuid
RUN apk del .build-deps $BUILD_DEPS
