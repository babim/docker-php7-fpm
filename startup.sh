#!/bin/sh

if [ -z "`ls /etc/php7`" ] 
then
	cp -R /etc-start/php7/* /etc/php7
fi

    # Set environments
    TIMEZONE1=${TIMEZONE:-Asia/Ho_Chi_Minh}
    PHP_MEMORY_LIMIT1=${PHP_MEMORY_LIMIT:-512M}
    MAX_UPLOAD1=${MAX_UPLOAD:-520M}
    PHP_MAX_FILE_UPLOAD1=${PHP_MAX_FILE_UPLOAD:-200}
    PHP_MAX_POST1=${PHP_MAX_POST:-520M}
    MAX_INPUT_TIME1=${MAX_INPUT_TIME:-3600}
    MAX_EXECUTION_TIME1=${MAX_EXECUTION_TIME:-3600}
	
	sed -i "s|;*date.timezone =.*|date.timezone = $TIMEZONE|i" /etc/php7/php.ini && \
	sed -i "s|;*memory_limit =.*|memory_limit = $PHP_MEMORY_LIMIT|i" /etc/php7/php.ini && \
 	sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = $MAX_UPLOAD|i" /etc/php7/php.ini && \
    	sed -i "s|;*max_file_uploads =.*|max_file_uploads = $PHP_MAX_FILE_UPLOAD|i" /etc/php7/php.ini && \
    	sed -i "s|;*post_max_size =.*|post_max_size = $PHP_MAX_POST|i" /etc/php7/php.ini && \
    	sed -i "s/max_input_time = 60/max_input_time = $MAX_INPUT_TIME/" /etc/php7/php.ini && \
	sed -i "s/max_execution_time = 30/max_execution_time = $MAX_EXECUTION_TIME/" /etc/php7/php.ini

    sed -i "s/;opcache.enable=0/opcache.enable=0/" /etc/php7/php.ini && \
    sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php7/php-fpm.conf && \
    sed -i '/^listen = /clisten = 9000' /etc/php5/php-fpm.d/www.conf && \
    sed -i '/^listen.allowed_clients/c;listen.allowed_clients =' /etc/php7/php-fpm.d/www.conf && \
    sed -i '/^;catch_workers_output/ccatch_workers_output = yes' /etc/php7/php-fpm.d/www.conf && \
    sed -i '/^;env\[TEMP\] = .*/aenv[DB_PORT_3306_TCP_ADDR] = $DB_PORT_3306_TCP_ADDR' /etc/php7/php-fpm.d/www.conf
    
exec "$@"
