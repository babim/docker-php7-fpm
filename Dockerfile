FROM babim/ubuntubase

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install software-properties-common -yq && add-apt-repository ppa:ondrej/php -y && \
    apt-get update && \
    apt-get install -y --force-yes imagemagick php7.1-fpm telnet inetutils-ping \
    php7.1-cgi php7.1-cli php7.1-phpdbg libphp7.1-embed php7.1-dev php-xdebug sqlite3 \
    php7.1-curl php7.1-gd php7.1-imap php7.1-interbase php7.1-intl php7.1-ldap php7.1-mcrypt php7.1-readline php7.1-odbc \
    php7.1-pgsql php7.1-pspell php7.1-recode php7.1-tidy php7.1-xmlrpc php7.1 php7.1-json php-all-dev php7.1-sybase \
    php7.1-sqlite3 php7.1-mysql php7.1-opcache php7.1-bz2 php7.1-mbstring php7.1-zip php-apcu php-imagick \
    php-memcached php-pear libsasl2-dev libssl-dev libsslcommon2-dev libcurl4-openssl-dev \
    php7.1-gmp php7.1-xml php7.1-bcmath php7.1-enchant php7.1-soap php7.1-xsl && \
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
	&& cp -R /etc/php/* /etc-start/php

COPY startup.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm7.1", "-F"]

# Define working directory.
WORKDIR /etc/php/7.1/fpm

ENV PHP_FPM_USER=www-data

EXPOSE 9000
