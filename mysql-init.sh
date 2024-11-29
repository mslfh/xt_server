#!/bin/sh

echo "Running mysql-init.sh"

# Check if the database 'adminjs' exists
if ! mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e 'USE adminjs'; then
  echo 'Database does not exist. Initializing database and running adminjs.sql';
  
  # Create the database 'adminjs'
  echo 'Creating database adminjs';
  mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e 'CREATE DATABASE IF NOT EXISTS adminjs';

  # Grant privileges to the root user
  echo 'Granting permissions to root user';
  mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;";

  # Execute the adminjs.sql script to initialize the database
  echo 'Running adminjs.sql';
  mysql -u root -p"$MYSQL_ROOT_PASSWORD" adminjs < /docker-entrypoint-initdb.d/adminjs.sql;
fi
