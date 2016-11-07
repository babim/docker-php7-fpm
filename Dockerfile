FROM babim/alpinebase:edge.cron

RUN apk add --no-cache \
    php7-fpm php7-cgi php7-phpdbg php7-dev sqlite imagemagick \
    php7-curl php7-gd php7-imap php7-intl php7-ldap php7-mcrypt php7-readline php7-odbc php7-exif php7-xml \
    php7-pgsql php7-pspell php7-ftp php7-tidy php7-xmlrpc php7 php7-json php7-ctype php7-zlib php7-bcmath \
    php7-sqlite3 php7-mysqli php7-opcache php7-bz2 php7-mbstring php7-zip  php7-soap php7-gettext \
    php7-pear php7-pdo_dblib php7-pdo_pgsql php7-pdo_odbc php7-pdo_sqlite php7-pdo_mysql php7-pdo

RUN sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php7/php.ini && \
    sed -i 's/\;date\.timezone\ \=/date\.timezone\ \=\ Asia\/Ho_Chi_Minh/g' /etc/php7/php.ini && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php7/php.ini && \
    sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 520M/" /etc/php7/php.ini && \
    sed -i "s/post_max_size = 8M/post_max_size = 520M/" /etc/php7/php.ini && \
    sed -i "s/max_input_time = 60/max_input_time = 3600/" /etc/php7/php.ini && \
    sed -i "s/max_execution_time = 30/max_execution_time = 3600/" /etc/php7/php.ini && \
    sed -i "s/;opcache.enable=0/opcache.enable=0/" /etc/php7/php.ini && \
    sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php7/php-fpm.conf && \
    sed -i '/^listen = /clisten = 9000' /etc/php7/php-fpm.d/www.conf && \
    sed -i '/^listen.allowed_clients/c;listen.allowed_clients =' /etc/php7/php-fpm.d/www.conf && \
    sed -i '/^;catch_workers_output/ccatch_workers_output = yes' /etc/php7/php-fpm.d/www.conf && \
    sed -i '/^;env\[TEMP\] = .*/aenv[DB_PORT_3306_TCP_ADDR] = $DB_PORT_3306_TCP_ADDR' /etc/php7/php-fpm.d/www.conf

RUN mkdir -p /var/www
VOLUME ["/var/www", "/etc/php7"]

RUN mkdir -p /etc-start/php7 \
	&& cp -R /etc/php7/* /etc-start/php7

COPY startup.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9000
