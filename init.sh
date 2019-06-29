#!/usr/bin/env sh
cd /var/www;
php app/console migrations:migrate --env=prod
rm -rf app/cache/*
php app/console cache:warmup --env=prod
chmod 777 app/cache/ -R
php-fpm7 -F &
nginx -g 'daemon off;' &
supervisord -c /etc/supervisor/conf/supervisord.conf &
tail -f /dev/null
