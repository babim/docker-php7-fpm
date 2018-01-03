#!/bin/bash
set -e
if [ -z "`ls /etc/php`" ]; then 
	cp -R /etc-start/php/* /etc/php/

   # Set environments
    TIMEZONE1=${TIMEZONE:-Asia/Ho_Chi_Minh}
    PHP_MEMORY_LIMIT1=${PHP_MEMORY_LIMIT:-512M}
    MAX_UPLOAD1=${MAX_UPLOAD:-520M}
    PHP_MAX_FILE_UPLOAD1=${PHP_MAX_FILE_UPLOAD:-200}
    PHP_MAX_POST1=${PHP_MAX_POST:-520M}
    MAX_INPUT_TIME1=${MAX_INPUT_TIME:-3600}
    MAX_EXECUTION_TIME1=${MAX_EXECUTION_TIME:-3600}
	
	sed -i -E \
	-e "s|;*date.timezone =.*|date.timezone = ${TIMEZONE1}|i" \
	-e "s|;*memory_limit =.*|memory_limit = ${MAX_UPLOAD1}|i" \
 	-e "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD1}|i" \
    	-e "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD1}|i" \
    	-e "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST1}|i" \
    	-e "s/max_input_time = 60/max_input_time = ${MAX_INPUT_TIME1}/" \
	-e "s/max_execution_time = 30/max_execution_time = ${MAX_EXECUTION_TIME1}/" \
	-e "s/error_reporting = .*/error_reporting = E_ALL/" \
	-e "s/display_errors = .*/display_errors = On/" \
	/etc/php/7.1/*/php.ini
	sed -i -e "s|^;*\(opcache.enable\) *=.*|\1 = 1|" /etc/php/7.1/*/php.ini
        sed -i -e "s|^;*\(opcache.enable_cli\) *=.*|\1 = 1|" /etc/php/7.1/*/php.ini
        sed -i -e "s|^;*\(opcache.fast_shutdown\) *=.*|\1 = 1|" /etc/php/7.1/*/php.ini
        sed -i -e "s|^;*\(opcache.interned_strings_buffer\) *=.*|\1 = 8|" /etc/php/7.1/*/php.ini
        sed -i -e "s|^;*\(opcache.max_accelerated_files\) *=.*|\1 = 4000|" /etc/php/7.1/*/php.ini
        sed -i -e "s|^;*\(opcache.memory_consumption\) *=.*|\1 = 128|" /etc/php/7.1/*/php.ini
	sed -i -e "s|^;*\(opcache.revalidate_freq\) *=.*|\1 = 60|" /etc/php/7.1/*/php.ini
	

    sed -i '/^listen = /clisten = 9000' /etc/php/7.1/fpm/pool.d/www.conf && \
    sed -i '/^listen.allowed_clients/c;listen.allowed_clients =' /etc/php/7.1/fpm/pool.d/www.conf && \
    sed -i '/^;catch_workers_output/ccatch_workers_output = yes' /etc/php/7.1/fpm/pool.d/www.conf && \
    sed -i '/^;env\[TEMP\] = .*/aenv[DB_PORT_3306_TCP_ADDR] = $DB_PORT_3306_TCP_ADDR' /etc/php/7.1/fpm/pool.d/www.conf
fi

# set ID docker run
agid=${agid:-$auid}
auser=${auser:-www-data}

if [[ -z "${auid}" ]]; then
  echo "start"
elif [[ "$auid" = "0" ]] || [[ "$aguid" == "0" ]]; then
	echo "run in user root"
	export auser=root
	sed -i -e "/^user = .*/cuser = $auser" /etc/php/7.1/fpm/php-fpm.conf
	sed -i -e "/^group = .*/cgroup = $auser" /etc/php/7.1/fpm/php-fpm.conf
elif id $auid >/dev/null 2>&1; then
        echo "UID exists. Please change UID"
else
if id $auser >/dev/null 2>&1; then
        echo "user exists"
	sed -i -e "/^user = .*/cuser = $auser" /etc/php/7.1//fpm/php-fpm.conf
	sed -i -e "/^group = .*/cgroup = $auser" /etc/php/7.1/fpm/php-fpm.conf
	# usermod alpine
		#deluser $auser && delgroup $auser
		#addgroup -g $agid $auser && adduser -D -H -G $auser -s /bin/false -u $auid $auser
	# usermod ubuntu/debian
		usermod -u $auid $auser
		groupmod -g $agid $auser
else
        echo "user does not exist"
	# create user alpine
	#addgroup -g $agid $auser && adduser -D -H -G $auser -s /bin/false -u $auid $auser
	# create user ubuntu/debian
	groupadd -g $agid $auser && useradd --system --uid $auid --shell /usr/sbin/nologin -g $auser $auser
	sed -i -e "/^user = .*/cuser = $auser" /etc/php/7.1/fpm/php-fpm.conf
	sed -i -e "/^group = .*/cgroup = $auser" /etc/php/7.1/fpm/php-fpm.conf
fi

fi

# ssh
if [ -f "/runssh.sh" ]; then /runssh.sh; fi
# cron
if [ -f "/runcron.sh" ]; then /runcron.sh; fi
# nfs
if [ -f "/mountnfs.sh" ]; then /mountnfs.sh; fi

exec "$@"
