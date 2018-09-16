FROM babim/ubuntubase:18.04

# Download option
RUN apt-get update && \
    apt-get install -y wget bash && cd / && wget --no-check-certificate https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh && \
    chmod 755 /option.sh

ENV PHP_VERSION 7.0
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install curl software-properties-common -yq && \
    apt-get update && touch /PHPFPM && \
    wget --no-check-certificate -O - https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20PHP%20install/php_install.sh | bash

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
CMD ["supervisord", "-nc", "/etc/supervisor/supervisord.conf"]

ENV PHP_FPM_USER=www-data

EXPOSE 9000
