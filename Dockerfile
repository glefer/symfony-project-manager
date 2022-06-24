# syntax=docker/dockerfile:1.4
ARG PHP_IMAGE=8.1.7
ARG COMPOSER_VERSION=2.3.7
FROM composer:${COMPOSER_VERSION} as composer

FROM php:${PHP_IMAGE}-fpm-alpine3.16
ARG PHP_IMAGE

MAINTAINER Gregory LEFER <12687145+glefer@users.noreply.github.com>
WORKDIR /app

# Install needed dependancies
RUN apk add --no-cache git
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Install symfony client
RUN cd /tmp \
    &&  wget https://github.com/symfony-cli/symfony-cli/releases/download/v5.4.11/symfony-cli_linux_amd64.tar.gz \
    && tar -zxvf symfony-cli_linux_amd64.tar.gz \
    && mv symfony /usr/local/bin \
    && rm -rf /tmp/*

# Install security checker
RUN curl -sSL https://github.com/fabpot/local-php-security-checker/releases/download/v2.0.3/local-php-security-checker_2.0.3_linux_amd64 -o /usr/local/bin/local-php-security-checker
RUN chmod +x /usr/local/bin/local-php-security-checker

# Copy configuration of the dependencies (grumphp, csfixer, phpstan, etc..)
COPY --link conf/php/${PHP_IMAGE}/* /conf/
COPY --link conf/php/common/* /conf/

# Add custom entrypoint
COPY --link conf/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/sh"]