#!/bin/sh

i=0
while ! mysqladmin -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD ping >/dev/null 2>&1; do
  if [ $i -eq 60 ]; then
    echo "Unable to connect to MariaDB after 5 minutes. Exiting."
    exit 1
  elif [ $i -eq 0 ]; then
    echo "Waiting for MariaDB at Wordpress ..."
  else
    echo "Waiting for MariaDB at Wordpress ... ${i}"
  fi
  sleep 5
  i=$(($i+1))
done
echo "Waiting for MariaDB at Wordpress ... done"

if [ -f "/var/www/html/wp-config.php" ]
then 
	echo "wordpress already downloaded"
else
	mkdir -p /var/www/html
	mkdir -p /var/run
	
	cd /var/www/html
	
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	
	chmod +x wp-cli.phar
		
	mv wp-cli.phar /usr/local/bin/wp
	
	wp core download --allow-root

	mv wp-config-sample.php wp-config.php

	sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
		
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
		
	sed -i "s/localhost/$MYSQL_HOST/g" wp-config.php
		
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php
	
	wp core install \
	--allow-root \
	--url=${DOMAIN_NAME} \
	--title=\'${WORDPRESS_TITLE}\' \
	--admin_user=\'${WORDPRESS_ADMIN}\' \
	--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
	--admin_email=${WORDPRESS_ADMIN_EMAIL} \
	--skip-email
	
	wp user create --allow-root --path=/var/www/html $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=contributor --user_pass=$WORDPRESS_USER_PASSWORD
	touch /var/www/html/.up
		
fi

exec /usr/sbin/php-fpm7.3 -F
