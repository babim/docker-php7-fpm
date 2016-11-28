FROM babim/alpinebase:edge

RUN apk add --no-cache \
    php7-fpm php7-cgi php7-phpdbg php7-dev sqlite imagemagick \
    php7-curl php7-gd php7-imap php7-intl php7-ldap php7-mcrypt php7-odbc php7-exif php7-xml \
    php7-pgsql php7-pspell php7-ftp php7-tidy php7-xmlrpc php7 php7-json php7-ctype php7-zlib php7-bcmath \
    php7-sqlite3 php7-mysqli php7-opcache php7-bz2 php7-mbstring php7-zip  php7-soap php7-gettext \
    php7-pear php7-pdo_dblib php7-pdo_pgsql php7-pdo_odbc php7-pdo_sqlite php7-pdo_mysql php7-pdo gettext

RUN mkdir -p /var/www
VOLUME ["/var/www", "/etc/php7"]

RUN mkdir -p /etc-start/php7 \
	&& cp -R /etc/php7/* /etc-start/php7

COPY startup.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm7", "-F"]

EXPOSE 9000
