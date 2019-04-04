#!/usr/bin/env sh

php-fpm7 -F &
nginx -g 'daemon off;' &
supervisord -c /var/www/app/config/supervisord.conf &
tail -f /dev/null	
