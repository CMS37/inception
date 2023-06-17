FROM debian:bullseye

RUN apt-get update && \
    apt-get -y install php7.3 php-fpm php-mysql curl mariadb-client && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /run/php && \
    curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xvzf wordpress.tar.gz && \
    rm -rf wordpress.tar.gz

CMD ["./usr/sbin/php-fpm7.3", "-F"]