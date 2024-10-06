#!/bin/sh

if [ ! -d /var/lib/mysql/adminjs ]; then
  echo 'Database does not exist. Initializing database and running adminjs.sql';
  
  # Initialize MySQL without a root password
  mysqld --initialize-insecure;
  mysqld --daemonize;

  echo 'Creating database adminjs';
  mysql -u root -e 'CREATE DATABASE IF NOT EXISTS adminjs';

  # Create root user for all hosts if it doesn't exist
  echo 'Creating root user for all hosts';
  mysql -u root -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY 'root';";

  # Set root password for both localhost and all hosts
  echo 'Setting root password if not set';
  mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';";
  mysql -u root -e "ALTER USER 'root'@'%' IDENTIFIED BY 'root';";

  # Grant all privileges to root user on all databases
  echo 'Granting permissions to root user';
  mysql -u root -p'root' -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;";

  # Grant specific access to the adminjs database
  echo 'Granting root user access to adminjs database';
  mysql -u root -p'root' -e "GRANT ALL PRIVILEGES ON adminjs.* TO 'root'@'%'; FLUSH PRIVILEGES;";

  echo 'Running adminjs.sql';
  mysql -u root -p'root' adminjs < /docker-entrypoint-initdb.d/adminjs.sql;

  echo 'Shutting down MySQL after initialization';
  mysqladmin -u root -p'root' shutdown;
fi

# Start the MySQL server with custom settings
exec mysqld --sql_mode='' --max_connections=1100 --general-log=1 --general-log-file=/tmp/mysql-general-log.log
