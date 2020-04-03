FROM debian:buster

LABEL maintainer="atrouill@student.42.fr"

RUN apt-get update && \
    apt-get install -y nginx php-fpm php-mysql php-mbstring mariadb-server openssl curl wget

COPY ./srcs/ ./root/

WORKDIR /root

# Install and configure mkcert
RUN curl -SL https://github.com/FiloSottile/mkcert/releases/download/v1.4.1/mkcert-v1.4.1-linux-amd64 -o /usr/local/bin/mkcert && \
    chmod +x /usr/local/bin/mkcert && \
    mkcert -install && \
    mkcert -key-file key.pem -cert-file cert.pem 127.0.0.1 localhost ::1

# Configure Nginx
RUN mv /var/www/html/* /var/www && \
    rm -rf /var/www/html && \
    rm -rf /etc/nginx/sites-enabled/* && \
    mv localhost.conf /etc/nginx/sites-available/ && \
    ln -s /etc/nginx/sites-available/localhost.conf /etc/nginx/sites-enabled/

# Configure MySQL
RUN service mysql start && \
    mysql -u root -e "CREATE DATABASE dbwordpress;" && \
    mysql -u root -e "GRANT ALL PRIVILEGES ON dbwordpress.* TO \"uwordpress\"@\"localhost\" IDENTIFIED BY \"password\";" && \
    mysql -u root -e "FLUSH PRIVILEGES;" && \
    mysql -u root -e "USE dbwordpress; SOURCE dbwordpress.sql;"

# Install and configure PHPMyAdmin
RUN wget -q https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz && \
    tar xzf phpMyAdmin-5.0.2-all-languages.tar.gz -C /var/www/ && \
    mv /var/www/phpMyAdmin-5.0.2-all-languages /var/www/phpmyadmin && \
    sed -e "s|cfg\['blowfish_secret'\] = ''|cfg['blowfish_secret'] = '$(openssl rand -base64 32)'|" /var/www/phpmyadmin/config.sample.inc.php > /var/www/phpmyadmin/config.inc.php

# Install and configure WordPress
RUN wget -q https://wordpress.org/latest.tar.gz && \
    tar xzf latest.tar.gz -C /var/www/ && \
    mv wp-config.php /var/www/wordpress 

# Configure Web directory
RUN chown -R www-data:www-data /var/www/* && \
    chmod -R 755 /var/www/*

CMD bash launch.sh
