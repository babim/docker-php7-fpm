FROM babim/ubuntubase:16.04

# Download option
RUN apt-get update && \
    apt-get install -y wget curl bash && cd / && wget --no-check-certificate https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh && \
    chmod 755 /option.sh

ENV PHP_VERSION 7.2
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install curl software-properties-common -yq && \
    curl -s https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20PHP%20install/php-repo-ubuntu.sh | bash && \
    apt-get update && touch /PHPFPM && \
    curl -s https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20PHP%20install/php7.2.sh | bash

RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /build && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

RUN mkdir -p /var/www
VOLUME ["/var/www", "/etc/php"]

ENTRYPOINT ["/start.sh"]
CMD ["php-fpm7.2", "-F"]

ENV PHP_FPM_USER=www-data

EXPOSE 9000
