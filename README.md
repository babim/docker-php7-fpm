# Usage

docker run --name php-fpm -p 9000:9000 -it -v /data/web:/var/www -v /data/phpconfig:/etc/php/7.0 babim/php7-fpm
