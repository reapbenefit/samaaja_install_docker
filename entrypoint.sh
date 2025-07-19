#!/bin/bash
set -e

# Add local bench to PATH
export PATH="/home/frappe/frappe-bench:$PATH"

SITE_NAME=${SITE_NAME:-local.mysite}
DB_HOST=${DB_HOST:-mariadb}
DB_PORT=${DB_PORT:-3306}
REDIS_URL=${REDIS_URL:-redis://redis:6379}
SOCKETIO_PORT=${SOCKETIO_PORT:-9000}
ADMIN_PASSWORD=${ADMIN_PASSWORD:-admin}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-root}
SAMAAJA_APP_BRANCH=${SAMAAJA_APP_BRANCH:-version-15}

cd /home/frappe/frappe-bench

echo "=== Environment Variables ==="
echo "SITE_NAME: $SITE_NAME"
echo "DB_HOST: $DB_HOST"
echo "DB_PORT: $DB_PORT"
echo "REDIS_URL: $REDIS_URL"
echo "SOCKETIO_PORT: $SOCKETIO_PORT"
echo "ADMIN_PASSWORD: $ADMIN_PASSWORD"
echo "MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD:0:4}****"
echo "=============================="

# ✅ Wait for MariaDB using correct credentials
echo "Waiting for MariaDB to accept connections..."
until mysqladmin ping -h"$DB_HOST" -uroot -p"$MYSQL_ROOT_PASSWORD" --silent; do
    echo "MariaDB not yet ready. Retrying..."
    sleep 2
done

echo "Setting Frappe configs..."
bench set-config -g db_host "$DB_HOST"
bench set-config -gp db_port "$DB_PORT"
bench set-config -g redis_cache "$REDIS_URL"
bench set-config -g redis_queue "$REDIS_URL"
bench set-config -g redis_socketio "$REDIS_URL"
bench set-config -gp socketio_port "$SOCKETIO_PORT"

if [ ! -d "sites/$SITE_NAME" ]; then
    echo "Creating site $SITE_NAME..."
    bench new-site "$SITE_NAME" \
      --admin-password "$ADMIN_PASSWORD" \
      --mariadb-root-password "$MYSQL_ROOT_PASSWORD" \
      --mariadb-user-host-login-scope='%'

    # Optional ERPNext installation (uncomment if needed)
    # bench get-app erpnext --branch version-15
    # bench --site "$SITE_NAME" install-app erpnext
else
    echo "Site $SITE_NAME already exists. Skipping site creation."
fi

# ✅ Install Samaaj app from GitHub if not already installed
if [ ! -d "apps/samaaj" ]; then
    echo "Installing Samaaj app..."
    bench get-app samaaj https://github.com/reapbenefit/Samaaja --branch "$SAMAAJA_APP_BRANCH"
    bench --site "$SITE_NAME" install-app samaaja
else
    echo "Samaaj app already exists. Skipping installation."
fi

exec bench start

