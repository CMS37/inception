FROM debian:buster

EXPOSE 3306

COPY ./tools/mariadb.sh /usr/local/bin/mariadb.sh

RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client vim && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /usr/local/bin/mariadb.sh && \
    touch /var/run/mysqld/mysqld.sock && \
    chown mysql:mysql /var/run/mysqld/mysqld.sock && \
    chmod 777 /var/run/mysqld/mysqld.sock && \
    sed -i 's/\r$//' /usr/local/bin/mariadb.sh

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

CMD ["mysqld", "--user=mysql", "--console", "--datadir=/var/lib/mysql"]
