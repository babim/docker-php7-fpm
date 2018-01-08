FROM babim/ubuntubase

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install software-properties-common -yq && add-apt-repository ppa:ondrej/php -y && \
    apt-get update && \
    apt-get install -y --force-yes imagemagick php7.2-fpm telnet inetutils-ping \
    php7.2-cgi php7.2-cli php7.2-phpdbg libphp7.2-embed php7.2-dev php-xdebug sqlite3 \
    php7.2-curl php7.2-gd php7.2-imap php7.2-interbase php7.2-intl php7.2-ldap php7.2-readline php7.2-odbc \
    php7.2-pgsql php7.2-pspell php7.2-recode php7.2-tidy php7.2-xmlrpc php7.2 php7.2-json php-all-dev php7.2-sybase \
    php7.2-sqlite3 php7.2-mysql php7.2-opcache php7.2-bz2 php7.2-mbstring php7.2-zip php-apcu php-imagick \
    php-memcached php-pear libsasl2-dev libssl-dev libsslcommon2-dev libcurl4-openssl-dev \
    php7.2-gmp php7.2-xml php7.2-bcmath php7.2-enchant php7.2-soap php7.2-xsl && \
    apt-get purge -y apache* && apt-get autoremove --purge -y

# Fix run suck
RUN mkdir -p /run/php/

# install option for webapp (owncloud)
RUN apt-get install -y --force-yes smbclient ffmpeg ghostscript openexr openexr openexr libxml2 gamin

RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /build && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

RUN mkdir -p /var/www
VOLUME ["/var/www", "/etc/php"]

RUN mkdir -p /etc-start/php \
	&& cp -R /etc/php/* /etc-start/php/

COPY startup.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
#CMD ["/entrypoint.sh"]
CMD ["php-fpm7.2", "-F"]

# Define working directory.
WORKDIR /etc/php/7.2/fpm

ENV PHP_FPM_USER=www-data

EXPOSE 9000
