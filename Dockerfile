FROM babim/ubuntubase

MAINTAINER "Duc Anh Babim" <ducanh.babim@yahoo.com>

RUN apt-get update && \
    apt-get install python-software-properties -y && add-apt-repository ppa:ondrej/php-7.0 -y && \
    apt-get update && apt-get install -y \
    php7.0-fpm \
    php7.0-curl \
    php7.0-gd \
    php7.0-geoip \
    php7.0-imagick \
    php7.0-imap \
    php7.0-json \
    php7.0-ldap \
    php7.0-mcrypt \
    php7.0-memcache \
    php7.0-memcached \
    php7.0-mongo \
    php7.0-mssql \
    php7.0-mysqlnd \
    php7.0-pgsql \
    php7.0-redis \
    php7.0-sqlite \
    php7.0-xdebug \
    php7.0-xmlrpc \
    php7.0-xcache \
    php7.0-tidy

RUN sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php7.0/fpm/php.ini && \
    sed -i 's/\;date\.timezone\ \=/date\.timezone\ \=\ Asia\/Ho_Chi_Minh/g' /etc/php7.0/fpm/php.ini && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php7.0/fpm/php.ini && \
    sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 520M/" /etc/php7.0/fpm/php.ini && \
    sed -i "s/;opcache.enable=0/opcache.enable=0/" /etc/php7.0/fpm/php.ini && \
    sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php7.0/fpm/php-fpm.conf && \
    sed -i '/^listen = /clisten = 9000' /etc/php7.0/fpm/pool.d/www.conf && \
    sed -i '/^listen.allowed_clients/c;listen.allowed_clients =' /etc/php7.0/fpm/pool.d/www.conf && \
    sed -i '/^;catch_workers_output/ccatch_workers_output = yes' /etc/php7.0/fpm/pool.d/www.conf && \
    sed -i '/^;env\[TEMP\] = .*/aenv[DB_PORT_3306_TCP_ADDR] = $DB_PORT_3306_TCP_ADDR' /etc/php7.0/fpm/pool.d/www.conf
    
RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /build && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

RUN mkdir -p /var/www
VOLUME ["/var/www"]

# Define working directory.
WORKDIR /etc/php7.0/fpm

ENV PHP_FPM_USER=www-data
ENV LC_ALL en_US.UTF-8
ENV TZ Asia/Ho_Chi_Minh

ENTRYPOINT ["/usr/sbin/php7.0-fpm", "-F"]

EXPOSE 9000
