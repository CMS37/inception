FROM debian:bullseye

RUN apt-get update && \
    apt-get -y install nginx openssl && \
    rm -rf /var/lib/apt/lists/*

COPY wordpress.conf /etc/nginx/sites-available/
COPY ng.sh /usr/local/bin

ENTRYPOINT [ "ng.sh" ]
