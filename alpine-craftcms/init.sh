#!/bin/sh

CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
touch $CONTAINER_ALREADY_STARTED
  echo "-- First container startup --"
  apk update && apk upgrade &&
    apk add --no-cache \
      build-base \
      oniguruma-dev \
      apache2 \
      apache2-proxy \
      apache2-ssl \
      libzip-dev \
      libxml2-dev \
      imagemagick \
      imagemagick-dev \
      postgresql-dev \
      php8 \
      php8-phar \
      php8-mbstring \
      php8-dev \
      php8-fpm \
      php8-dom \
      php8-pdo_pgsql \
      php8-fileinfo \
      php8-ctype \
      php8-tokenizer \
      php8-openssl \
      php8-curl \
      php8-zip \
      php8-session \
      php8-pecl-imagick \
      supervisor \
      composer &&
    ln -s -f /usr/bin/php8 /usr/bin/php &&
    ln -s -f /usr/bin/php-config8 /usr/bin/php-config &&
    ln -s -f /usr/bin/phpize8 /usr/bin/phpize &&
    ln -s -f /usr/bin/phar8 /usr/bin/phar &&
    ln -s -f /usr/bin/phar.phar8 /usr/bin/phar.phar &&
    ln -s -f /usr/sbin/php-fpm8 /usr/sbin/php-fpm &&
    cp ./config/supervisord.conf /etc/supervisord.conf &&
    cp ./config/httpd.conf /etc/apache2/httpd.conf &&
    cp ./config/www.conf /etc/php8/php-fpm.d/www.conf &&
    composer u &&
    adduser -S -D -G www-data www-data &&
    chown -R :www-data \
      .env \
      composer.json \
      composer.lock \
      config/license.key \
      config/project \
      storage \
      web/cpresources \
      vendor &&
    chmod -R 774 \
      .env \
      composer.json \
      composer.lock \
      config/license.key \
      config/project \
      storage \
      web/cpresources \
      vendor &&
    php craft setup/app-id &&
    php craft setup/security-key &&
    /usr/bin/supervisord -c /etc/supervisord.conf
else
  echo "-- Not first container startup --"
  /usr/bin/supervisord -c /etc/supervisord.conf
fi


