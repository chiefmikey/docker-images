FROM alpine:latest
EXPOSE 3000
WORKDIR /craft
COPY . .
RUN apk update && apk upgrade
RUN apk add --no-cache \
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
  composer
RUN ln -s -f /usr/bin/php8 /usr/bin/php
RUN ln -s -f /usr/bin/php-config8 /usr/bin/php-config
RUN ln -s -f /usr/bin/phpize8 /usr/bin/phpize
RUN ln -s -f /usr/bin/phar8 /usr/bin/phar
RUN ln -s -f /usr/bin/phar.phar8 /usr/bin/phar.phar
RUN ln -s -f /usr/sbin/php-fpm8 /usr/sbin/php-fpm
COPY ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./config/httpd.conf /etc/apache2/httpd.conf
COPY ./config/www.conf /etc/php8/php-fpm.d/www.conf
RUN composer u
RUN adduser -S -D -G www-data www-data
RUN chown -R :www-data \
  .env \
  composer.json \
  composer.lock \
  config/license.key \
  config/project \
  storage \
  web/cpresources \
  vendor
RUN chmod -R 774 \
  .env \
  composer.json \
  composer.lock \
  config/license.key \
  config/project \
  storage \
  web/cpresources \
  vendor
# RUN chown -R :www-data /api
# RUN chmod -R 774 /api
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
HEALTHCHECK --interval=5m --timeout=10s \
  CMD curl --silent --fail http://127.0.0.1:3000/fpm-ping.php
