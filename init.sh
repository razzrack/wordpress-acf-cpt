#!/bin/bash
set -e

# Display the script
echo "🕒 Waiting for DB to be ready..."
# Extract host and port from WORDPRESS_DB_HOST
DB_HOST=$(echo "$WORDPRESS_DB_HOST" | cut -d':' -f1)
DB_PORT=$(echo "$WORDPRESS_DB_HOST" | cut -d':' -f2)
# Wait until MySQL is accepting connections
until mysqladmin ping -h"$DB_HOST" -P"$DB_PORT" -u root -p"$MYSQL_ROOT_PASSWORD" --silent; do
    echo "   ⏳ Still waiting for database..."
    sleep 2
done
echo "✅ Database server is ready."

# Create database if it doesn't exist
if ! mysql -h"$DB_HOST" -P"$DB_PORT" -u root -p"$MYSQL_ROOT_PASSWORD" -e "USE ${MYSQL_DATABASE};" 2>/dev/null; then
    echo "🛠 Creating database '${MYSQL_DATABASE}'..."
    mysql -h"$DB_HOST" -P"$DB_PORT" -u root -p"$MYSQL_ROOT_PASSWORD" \
        -e "CREATE DATABASE \`${MYSQL_DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    echo "✅ Database '${MYSQL_DATABASE}' created."
else
    echo "✅ Database '${MYSQL_DATABASE}' already exists."
fi

# Change directory
cd /var/www/html
# Ensure upload directories are writable
mkdir -p wp-content/{uploads,plugins,themes}
# Set ownership
echo "🔧 Fixing permissions..."
chown -R www-data:www-data wp-content/{uploads,plugins,themes}
chmod -R 775 wp-content/{uploads,plugins,themes}

# ⚙️ Create wp-config.php if missing
if [ ! -f wp-config.php ]; then
  echo "⚙️ Creating wp-config.php..."
  wp config create \
    --dbname="$MYSQL_DATABASE" \
    --dbuser="root" \
    --dbpass="$MYSQL_ROOT_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST" \
    --skip-check \
    --allow-root \
    --extra-php <<'PHP'
/**
 * 🔧 Custom WordPress Configurations
 */
define('FS_METHOD', 'direct'); // Avoid FTP prompt when installing plugins/themes

// Set HTTP_HOST fallback when running from CLI
if (php_sapi_name() === 'cli') {
    $_SERVER['HTTP_HOST'] = $_SERVER['HTTP_HOST'] ?? 'localhost';
}
PHP

else
  echo "✅ wp-config.php already exists"
fi
# Check if WordPress is already installed
if wp core is-installed --allow-root; then
  echo "✅ WordPress already installed"
else
  echo "🚀 Installing WordPress..."
  # Only download core files if not present
  if [ ! -f wp-settings.php ]; then
    wp core download --allow-root
  fi
  wp core install \
    --url="$SITE_URL" \
    --title="$SITE_TITLE" \
    --admin_user="$WORDPRESS_ADMIN_USER" \
    --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
    --admin_email="$WORDPRESS_ADMIN_EMAIL" \
    --skip-email \
    --allow-root
fi

echo "✅ WordPress setup complete."

# Continue with the original WordPress entrypoint (Apache foreground)
exec apache2-foreground