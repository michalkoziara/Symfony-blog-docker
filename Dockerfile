# ---- Base ----
FROM ubuntu:latest AS base
RUN apt-get update -yq
LABEL maintainer="Michal Koziara mkoziara12@gmail.com"

# ---- Base dependencies ----
FROM base AS dependency
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -yq curl php-cli php-pgsql git unzip php-mbstring php-xml php-apcu php-curl php-zip

# ---- App ----
FROM dependency AS app
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
git clone https://github.com/michalkoziara/Symfony-blog
WORKDIR /Symfony-blog
RUN composer install && \
composer require server --dev

# ---- Release ----
FROM dependency AS realese
COPY --from=app /Symfony-blog /Symfony-blog
WORKDIR /Symfony-blog/bin
CMD php console server:run 0.0.0.0:8005 --env=dev
