[![](https://images.microbadger.com/badges/image/babim/php7-fpm.svg)](https://microbadger.com/images/babim/php7-fpm "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/php7-fpm.svg)](https://microbadger.com/images/babim/php7-fpm "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/babim/php7-fpm:ssh.svg)](https://microbadger.com/images/babim/php7-fpm:ssh "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/php7-fpm:ssh.svg)](https://microbadger.com/images/babim/php7-fpm:ssh "Get your own version badge on microbadger.com")

[![](https://images.microbadger.com/badges/image/babim/php7-fpm:cron.svg)](https://microbadger.com/images/babim/php7-fpm:cron "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/php7-fpm:cron.svg)](https://microbadger.com/images/babim/php7-fpm:cron "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/babim/php7-fpm:cron.ssh.svg)](https://microbadger.com/images/babim/php7-fpm:cron.ssh "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/php7-fpm:cron.ssh.svg)](https://microbadger.com/images/babim/php7-fpm:cron.ssh "Get your own version badge on microbadger.com")

[![](https://images.microbadger.com/badges/image/babim/php7-fpm:cron.synology.svg)](https://microbadger.com/images/babim/php7-fpm:cron.synology "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/php7-fpm:cron.synology.svg)](https://microbadger.com/images/babim/php7-fpm:cron.synology "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/babim/php7-fpm:cron.nfs.svg)](https://microbadger.com/images/babim/php7-fpm:cron.nfs "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/php7-fpm:cron.nfs.svg)](https://microbadger.com/images/babim/php7-fpm:cron.nfs "Get your own version badge on microbadger.com")

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
