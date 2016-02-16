#!/bin/bash
if [ -z "`ls /etc/php/7.0`" ] 
then
	cp -R /etc-start/php/7.0 /etc/php/7.0
fi

service php7.0-fpm start
