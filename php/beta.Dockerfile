# Version check
# https://www.php.net/
# https://github.com/docker-library/php
# https://hub.docker.com/_/php/tags
FROM php:8.4-fpm

# https://gist.github.com/lehungio/acc2bfc681349f678965a5d677168e88#file-dockerfile-L5
# SHELL ["/bin/bash", "-l", "-euxo", "pipefail", "-c"]
SHELL ["/bin/bash", "--login", "-c"]

RUN apt-get update; \
    apt-get full-upgrade -y; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
    ; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

# https://stackoverflow.com/a/25908200
RUN apt-get update && \
      apt-get -y install sudo wget

# Replace shell with bash so we can source files
# https://stackoverflow.com/questions/25899912/how-to-install-nvm-in-docker
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set debconf to run non-interactively
# debconf: delaying package configuration, since apt-utils is not installed
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# RUN pecl install redis \
#     && pecl install xdebug \
#     && docker-php-ext-enable redis xdebug

# install basic system tools
RUN (seq 1 8 | xargs -I{} mkdir -p /usr/share/man/man{}) \
    && apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install bash git make unzip gnupg ca-certificates apt-utils apt-transport-https netcat-traditional \
    && apt-get purge -y --auto-remove && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && git config --system --add url."https://github.com/".insteadOf "git@github.com:" \
    && git config --system --add url."https://github.com/".insteadOf "ssh://git@github.com/" \
    # fix git repository directory is owned by someone else for Github Actions
    && { echo '#!/bin/sh'; echo 'if [ -n "$GITHUB_WORKSPACE" ] && [ "$(id -u)" -eq 0 ]; then'; echo '    (cd / && /usr/bin/git config --global --add safe.directory "$GITHUB_WORKSPACE")'; echo 'fi'; echo '/usr/bin/git "$@"'; } > /usr/local/bin/git && chmod +x /usr/local/bin/git

# install common PHP extensions
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN git clone --recurse-submodules https://github.com/phpredis/phpredis.git -b develop phpredis \
    && cd phpredis && git reset --hard d3b2d87b10 && rm -r .git
RUN git clone https://github.com/xdebug/xdebug.git -b master xdebug \
    && cd xdebug && git reset --hard 12adc6394a && rm -r .git \
    && sed 's~<max>8.4.99</max>~<max>99.99.99</max>~' -i package.xml
RUN IPE_ICU_EN_ONLY=1 install-php-extensions \
    bcmath \
    exif \
    gd \
    gmp \
    igbinary \
    Imagick/imagick@ef495c0b8f \
    php/pecl-mail-imap@25b62dbf7b \
    intl \
    mysqli \
    php/pecl-database-oci8@74893c6e3d \
    opcache \
    pcntl \
    pdo_mysql \
    php/pecl-database-pdo_oci@be8a277c27 \
    pdo_pgsql \
    pdo_sqlsrv \
    $(realpath phpredis) \
    sockets \
    tidy \
    $(realpath xdebug) \
    xsl \
    zip \
    # pack Oracle Instant Client libs, reduce image size by 85 MB
    && rm /usr/lib/oracle/*/client64/lib/*.jar && tar -czvf /usr/lib/oracle-pack.tar.gz -C / /usr/lib/oracle /usr/local/etc/php/conf.d/docker-php-ext-pdo_oci.ini /usr/local/etc/php/conf.d/docker-php-ext-oci8.ini && rm -r /usr/lib/oracle/* /usr/local/etc/php/conf.d/docker-php-ext-pdo_oci.ini /usr/local/etc/php/conf.d/docker-php-ext-oci8.ini && mv /usr/lib/oracle-pack.tar.gz /usr/lib/oracle/pack.tar.gz \
    && { echo '#!/bin/sh'; echo 'if [ ! -d /usr/lib/oracle/*/client64 ]; then'; echo '    tar -xzf /usr/lib/oracle/pack.tar.gz -C / && rm /usr/lib/oracle/pack.tar.gz'; echo 'fi'; } > /usr/lib/oracle/setup.sh && chmod +x /usr/lib/oracle/setup.sh

# TODO memcached
# RUN apt-get update && apt-get install -y \
#     libmemcached-dev \
#     zlib1g-dev \
#     pkg-config \
#     build-essential \
#     && pecl install memcached --with-libmemcached-dir=/usr \
#     && docker-php-ext-enable memcached

# install Composer
RUN install-php-extensions @composer

RUN apt-get update && apt-get upgrade -y
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpq-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libssl-dev \
    libssl-doc \
    libsasl2-dev \
    zlib1g-dev \
    libicu-dev \
    g++ \
    zip \
    git

RUN apt-get update
RUN apt-get install -y -q --no-install-recommends \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    rsync \
    software-properties-common \
    devscripts \
    autoconf \
    ssl-cert \
    && apt-get clean

# Check for broken packages
RUN apt-get install -f

# Upgrade system packages
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y

# Install python3.11
RUN apt-get install -y python3.11

# Deprecated mbstring, mcrypt, zip
RUN docker-php-ext-install bz2
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pgsql
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install soap

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

# exif
RUN docker-php-ext-configure exif
RUN docker-php-ext-install exif
# RUN docker-php-ext-enable exif 
# warning: exif (exif.so) is already loaded!

# zip
RUN apt-get install -y libzip-dev zip && docker-php-ext-install zip

# intl
RUN docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-enable intl

# imagick
RUN apt-get update && apt-get upgrade -y
# Replace the lines containing TSRMLS_SET_CTX in imagick_class.c with comments
RUN apt-get update \
    && apt-get install -y libmagickwand-dev \
    && curl -L -o /tmp/imagick.tar.gz https://pecl.php.net/get/imagick-3.5.1.tgz \
    && tar xvzf /tmp/imagick.tar.gz -C /tmp \
    && cd /tmp/imagick-3.5.1 \
    && phpize \
    && ./configure --with-imagick=shared \
    && make \
    && make install \
    && docker-php-ext-enable imagick \
    && rm -rf /tmp/imagick.tar.gz /tmp/imagick-3.5.1

# Node dependencies
# https://github.com/nodejs/Release
# Fix node -v command not found
# https://gist.github.com/remarkablemark/aacf14c29b3f01d6900d13137b21db3a
# https://gist.github.com/remarkablemark/aacf14c29b3f01d6900d13137b21db3a#gistcomment-3067813
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION latest

RUN mkdir -p "$NVM_DIR"; \
    curl -o- \
        "https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh" | \
        bash \
    ; \
    source $NVM_DIR/nvm.sh; \
    nvm install --lts --latest-npm

# TODO This loads nvm
# this command can not load properly when build, but  can run directly in ssh
# RUN [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
# https://stackoverflow.com/questions/25899912/how-to-install-nvm-in-docker

# update the repository sources list
# and install dependencies
# https://github.com/nodesource/distributions/blob/master/deb/src/_setup.sh#L114
# RUN curl -sL https://deb.nodesource.com/setup_17.x | bash -
# RUN apt-get install -y nodejs npm
RUN npm install yarn -g

# mysql dependencies
RUN apt-get update && apt-get install -y \
    vim \
    default-mysql-client \
    netcat-openbsd

# ENV
# /usr/local/nvm/versions/node/v16.13.1/bin/node
# /usr/local/nvm/versions/node/v16.13.1/lib/node_modules/
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Summary installation
# 01. PHP
RUN php -r "phpinfo();"
RUN php --ini
RUN php --version

RUN uname -a
RUN whoami
RUN pwd

# https://stackoverflow.com/questions/55206227/why-bashrc-is-not-executed-when-run-docker-container
# CMD source ~/.bashrc
# 02. NVM / Node / Yarn
RUN nvm --version
RUN node -v
RUN npm -v
RUN yarn -v

# 03. MYSQL CLIENT
RUN mysql --version

# 04. npm dependencies
RUN npm install -g jest
RUN jest --version

# TODO 05. Redis & memcached
RUN ls /usr/include/
RUN ls /usr/lib/

# Disk usage
RUN df -h