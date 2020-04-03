#!/bin/bash

service mysql start

if [[ ! -z "${AUTO_INDEX}" ]] && [[ "${AUTO_INDEX}" = "OFF" ]]; then
		sed -i "s/autoindex on;/autoindex off;/g" /etc/nginx/sites-available/localhost.conf
fi

if [[ ! -z "${DEV_CERT}" ]] && [[ "${DEV_CERT}" = "YES" ]]; then
	mv key_dev.pem /etc/ssl/private/key.pem
	mv cert_dev.pem /etc/ssl/certs/cert.pem
	rm -rf key.pem cert.pem
	chown root:root /etc/ssl/private/key.pem
	chmod 0600 /etc/ssl/private/key.pem
else
	mv key.pem /etc/ssl/private/key.pem
	mv cert.pem /etc/ssl/certs/cert.pem
	rm -rf key_dev.pem cert_dev.pem
	chown root:root /etc/ssl/private/key.pem
	chmod 0600 /etc/ssl/private/key.pem
fi

if [[ ! -z "${SQL_USERNAME}" ]]; then 
	mysql -u root -e "RENAME USER 'uwordpress'@'localhost' TO '${SQL_USERNAME}'@'localhost';"
	mysql -u root -e "FLUSH PRIVILEGES;"
	sed -i "s/define( 'DB_USER', 'uwordpress' );/define( 'DB_USER', '${SQL_USERNAME}' );/g" /var/www/wordpress/wp-config.php
fi

if [[ ! -z "${SQL_PASSWORD}" ]]; then
	if [[ ! -z "${SQL_USERNAME}" ]]; then 
		mysql -u root -e "ALTER USER '${SQL_USERNAME}'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
		mysql -u root -e "FLUSH PRIVILEGES;"
	else
		mysql -u root -e "ALTER USER 'uwordpress'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
		mysql -u root -e "FLUSH PRIVILEGES;"
	fi
	sed -i "s/define( 'DB_PASSWORD', 'password' );/define( 'DB_PASSWORD', '${SQL_PASSWORD}' );/g" /var/www/wordpress/wp-config.php
fi

if [[ ! -z "${WP_USERNAME}" ]]; then
	mysql -u root -e "USE dbwordpress; UPDATE wp_users SET user_login='${WP_USERNAME}' WHERE ID = 1;"
	mysql -u root -e "USE dbwordpress; UPDATE wp_users SET user_nicename='${WP_USERNAME}' WHERE ID = 1;"
	mysql -u root -e "FLUSH PRIVILEGES;"
fi

if [[ ! -z "${WP_PASSWORD}" ]]; then
	mysql -u root -e "USE dbwordpress; UPDATE wp_users SET user_pass= MD5('${WP_PASSWORD}') WHERE ID = 1;"
	mysql -u root -e "FLUSH PRIVILEGES;"
fi

service nginx start
service php7.3-fpm start

echo "Sleeping..."
# Spin until we receive a SIGTERM (e.g. from `docker stop`)
trap 'exit 143' SIGTERM # exit = 128 + 15 (SIGTERM)
tail -f /dev/null & wait ${!}