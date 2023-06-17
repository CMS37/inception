FROM debian:bullseye


RUN apt-get update && \
    apt-get -y install mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY db.sh /usr/local/bin/

ENTRYPOINT [ "db.sh" ]

CMD [ "mysqld_safe" ]