FROM babim/ubuntubase

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install software-properties-common -yq && add-apt-repository ppa:ondrej/php -y && \
    apt-get update && \
    apt-get install -y --force-yes imagemagick php7.0-fpm telnet \
    php7.0-cgi php7.0-cli php7.0-phpdbg libphp7.0-embed php7.0-dev php-xdebug sqlite3 \
    php7.0-curl php7.0-gd php7.0-imap php7.0-interbase php7.0-intl php7.0-ldap php7.0-mcrypt php7.0-readline php7.0-odbc \
    php7.0-pgsql php7.0-pspell php7.0-recode php7.0-tidy php7.0-xmlrpc php7.0 php7.0-json php-all-dev php7.0-sybase \
    php7.0-sqlite3 php7.0-mysql php7.0-opcache php7.0-bz2 php7.0-mbstring php7.0-zip php-apcu php-imagick \
    php-memcached php-pear libsasl2-dev libssl-dev libsslcommon2-dev libcurl4-openssl-dev \
    php7.0-gmp php7.0-xml php7.0-bcmath php7.0-enchant php7.0-soap php7.0-xsl && \
    apt-get purge -y apache* && apt-get autoremove --purge -y

# Fix run suck
RUN mkdir -p /run/php/

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
	&& cp -R /etc/php/* /etc-start/php

COPY startup.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm7.0", "-F"]

# Define working directory.
WORKDIR /etc/php/7.0/fpm

ENV PHP_FPM_USER=www-data

EXPOSE 9000
