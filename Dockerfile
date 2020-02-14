# Base image
FROM ubuntu:bionic

# Set an environment variable
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

# Install dependencies
RUN apt update \
    && apt install -y software-properties-common vim wget curl git build-essential mysql-client libpq-dev apt-transport-https ca-certificates \
    && add-apt-repository -y ppa:ondrej/php \
    && apt update \
    && apt install -y nginx nginx-extras redis-tools php7.4 php7.4-fpm php7.4-curl php7.4-mysql php7.4-opcache php7.4-xml php7.4-gd php7.4-mysql php7.4-intl php7.4-mbstring php7.4-bcmath php7.4-zip php7.4-apc php7.4-apcu php7.4-bz2 php7.4-imagick php7.4-mongodb php7.4-sqlite php7.4-ssh2 php7.4-apc php7.4-apcu php7.4-bz2 php7.4-imagick php7.4-mongodb php7.4-sqlite php7.4-ssh2 \
    && apt-get -y install php7.4-dev gcc make autoconf libc-dev pkg-config libmcrypt-dev \
    && pecl channel-update pecl.php.net \
    && yes | pecl install mcrypt-1.0.3 \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Run and expose it to the world
CMD php-fpm7.4 && nginx
EXPOSE 80
