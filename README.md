# Usage
```
docker run --name php-fpm -p 9000:9000 -it -v /data/web:/var/www -v /data/phpconfig:/etc/php/7.0 babim/php7-fpm
```

Volume:
```
/var/www
/etc/php
```
Environment
```
TIMEZONE
PHP_MEMORY_LIMIT
MAX_UPLOAD
PHP_MAX_FILE_UPLOAD
PHP_MAX_POST
MAX_INPUT_TIME
MAX_EXECUTION_TIME
```
with environment ID:
```
auid = user id
agid = group id
auser = username
Default: agid = auid
```
