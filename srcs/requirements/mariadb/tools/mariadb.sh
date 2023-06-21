#!/bin/sh

set -e

if [ ! -d "/var/lib/mariadb/$MYSQL_DATABASE" ]; then
  mysql_install_db --datadir=/var/lib/mariadb --auth-root-authentication-method=normal
  mysqld --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE DATABASE $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

  if [ $? -eq 0 ]; then
    echo "MariaDB setup completed."
  else
    echo "Failed to complete MariaDB setup."
    exit 1
  fi
else
  echo "Database already exists."
fi

exec mysqld --datadir=/var/lib/mariadb
