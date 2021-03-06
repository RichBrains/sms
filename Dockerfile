FROM alpine:3.9


RUN addgroup www-data && adduser -S -D -G www-data www-data

RUN  apk --update add \
        bash \
        git \
        curl \
        php7 \
        nginx \
        mysql \
	mysql-client \
	supervisor \
        php7-dom \
        php7-ctype \
        php7-curl \
        php7-exif \
        php7-fpm \
        php7-gd \
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-mysqlnd \
        php7-opcache \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_dblib \
        php7-posix \
        php7-session \
        php7-xml \
        php7-iconv \
        php7-phar \
        php7-openssl \
        php7-ldap  \
        php7-mongodb \
        php7-soap \
        php7-zip \
        php7-imagick \
        php7-tokenizer \
        php7-simplexml \
        php7-xmlwriter \
        php7-pecl-memcached \
        php7-memcached \
        php7-redis \
        openjdk7-jre \
        ttf-freefont \
        ghostscript \
 && rm -rf /var/cache/apk/*


COPY php.ini       /etc/php7/conf.d/50-setting.ini
COPY php-fpm.conf  /etc/php7/php-fpm.conf

ONBUILD COPY . /var/www

#RUN ln -s /usr/bin/php7 /usr/bin/php
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer&& \
    mkdir -p /run/nginx

COPY ./init.sh /
COPY ./default.conf /etc/nginx/conf.d/default.conf
RUN chmod +x /init.sh

EXPOSE 80

ENTRYPOINT [ "/init.sh" ]
