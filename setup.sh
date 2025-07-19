#!/bin/bash

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be available..."
until mysqladmin ping -h mariadb --silent; do
  sleep 2
done

# Create site if not already created
if [ ! -f "./sites/myngo/site_config.json" ]; then
  echo "Creating new Frappe site..."
  bench new-site myngo \
    --mariadb-root-password "$MYSQL_ROOT_PASSWORD" \
    --admin-password admin \
    --no-mariadb-socket

  bench get-app --branch CopySN https://github.com/reapbenefit/Samaaja.git
  bench --site myngo install-app samaaja
fi

echo "Starting bench..."
exec bench start

