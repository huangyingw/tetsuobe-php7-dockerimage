FROM php:7.0.2-fpm

RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y git libssl-dev zlib1g-dev libicu-dev g++

# Install PHP extensions
#RUN pecl install xdebug
#RUN echo zend_extension=xdebug.so > /usr/local/etc/php/conf.d/xdebug.ini
RUN pecl install apcu
RUN echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini
RUN docker-php-ext-install zip mbstring intl

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer
