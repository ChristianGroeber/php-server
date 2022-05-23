FROM php:7.4-apache

RUN docker-php-ext-install pdo_mysql

RUN pecl install apcu

RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod expires

RUN apt-get update && \
    apt-get install -y \
    libzip-dev \
    libmcrypt-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libicu-dev \
    zlib1g-dev \
    snapd \
    unzip \
    wget \
    libwebp-dev \
    libpng-dev

COPY apache-conf/ /usr/local/etc/php/conf.d

# RUN pecl channel-update pecl.php.net
# RUN pecl install mcrypt-1.0.3
# RUN docker-php-ext-enable mcrypt

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp
RUN docker-php-ext-install gd

RUN docker-php-ext-install zip
RUN docker-php-ext-enable apcu

RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "echo PHP_EOL;" \
    && php composer-setup.php --filename=composer \
    && php -r "unlink('composer-setup.php');" \
    && mv composer /usr/local/bin/composer

WORKDIR /var/www/html
