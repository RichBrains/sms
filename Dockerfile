FROM richbrains/sms:base

RUN  apk --update add nginx php7-fpm

COPY php-fpm.conf  /etc/php7/php-fpm.conf

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer&& \
    mkdir -p /run/nginx

COPY ./init.sh /
COPY ./default.conf /etc/nginx/conf.d/default.conf

RUN chmod +x /init.sh

EXPOSE 80

ENTRYPOINT [ "/init.sh" ]
