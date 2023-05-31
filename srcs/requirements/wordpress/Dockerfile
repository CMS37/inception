FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y php php-fpm php-mysql curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xzf wordpress.tar.gz -C /var/www/ && \
    rm wordpress.tar.gz && \
    chown -R www-data:www-data /var/www/wordpress

CMD ["php-fpm7.4", "-F"]
