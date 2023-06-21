FROM debian:buster
EXPOSE 9000

COPY ./tools/wp.sh /usr/local/bin/wp.sh

RUN apt-get update && \
    apt-get install -y \
            php7.3 \
            php-fpm \
            php-cli \  
            php-mysql \
            php-mbstring \
            php-xml \
            curl \
            wget \
            # sendmail \
            # vim \
            mariadb-client && \
	rm -rf /var/lib/apt/lists/* && \
    mkdir -p /run/php && \
    chmod +x /usr/local/bin/wp.sh && \
    sed -i 's/\r$//' /usr/local/bin/wp.sh

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

ENTRYPOINT ["/usr/local/bin/wp.sh"]

WORKDIR /var/www/html/

CMD ["/usr/sbin/php-fpm7.3", "-F"]
