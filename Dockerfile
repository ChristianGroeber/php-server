FROM php:8.2-apache

MAINTAINER pixlmint

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions

RUN install-php-extensions gd
RUN install-php-extensions xdebug
RUN install-php-extensions @composer
RUN install-php-extensions zip
RUN install-php-extensions intl
RUN install-php-extensions apcu

RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod expires

COPY apache-conf/ /usr/local/etc/php/conf.d

WORKDIR /var/www/html
