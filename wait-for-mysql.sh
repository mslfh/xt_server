#!/bin/sh

echo "Running wait-for-mysql.sh"

until mysqladmin ping -h "mysql" --silent; do
  echo "Waiting for MySQL to be ready..."
  sleep 5
done

echo "MySQL is ready!"
npm start
