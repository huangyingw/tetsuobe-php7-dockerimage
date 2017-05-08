FROM php:7.1.4-fpm

RUN apt-get update && \
	apt-get install -y git wget libssl-dev zlib1g-dev libicu-dev g++ uuid-dev && \
    apt-get autoclean -y && \
    apt-get clean -y

# Install PHP extensions
RUN pecl install xdebug && \
	echo zend_extension=xdebug.so > /usr/local/etc/php/conf.d/xdebug.ini && \
	pecl install apcu && \
	echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini && \
    pecl install uuid && \
    echo extension=uuid.so > /usr/local/etc/php/conf.d/uuid.ini && \
	docker-php-ext-install zip mbstring intl bcmath && \
    echo extension=bcmath.so > /usr/local/etc/php/conf.d/docker-php-ext-bcmath.ini

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer
