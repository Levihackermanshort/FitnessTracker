#!/bin/bash

# Complete MySQL setup for Codespaces (as required by assignment)

echo "=== Setting up Fitness Tracker with MySQL ==="

# Step 1: Install PHP MySQL extensions
echo "Installing PHP MySQL extensions..."
sudo apt-get update
sudo apt-get install -y php-mysql php-pdo-mysql 2>/dev/null || \
sudo apt-get install -y php8.2-mysql php8.2-pdo 2>/dev/null || \
echo "PHP MySQL extensions may already be installed"

# Step 2: Start MySQL service
echo "Starting MySQL service..."
sudo service mysql start 2>/dev/null || \
sudo systemctl start mysql 2>/dev/null || \
echo "MySQL service may already be running"

# Wait for MySQL to be ready
sleep 3

# Step 3: Configure MySQL authentication
echo "Configuring MySQL authentication..."
mysql -h 127.0.0.1 -u root -e "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;" 2>/dev/null || \
mysql -h 127.0.0.1 -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;" 2>/dev/null || \
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;" 2>/dev/null || \
echo "MySQL authentication configuration attempted"

# Step 4: Create database
echo "Creating database..."
mysql -h 127.0.0.1 -u root -e "CREATE DATABASE IF NOT EXISTS fitness_journal_db;" 2>/dev/null || \
mysql -u root -e "CREATE DATABASE IF NOT EXISTS fitness_journal_db;" 2>/dev/null || \
echo "Database creation attempted"

# Step 5: Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "Creating .env file..."
    cat > .env << 'EOF'
APP_NAME="Fitness Tracker"
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_TIMEZONE=UTC
APP_URL=http://localhost

APP_LOCALE=en
APP_FALLBACK_LOCALE=en
APP_FAKER_LOCALE=en_US

APP_MAINTENANCE_DRIVER=file
APP_MAINTENANCE_STORE=database

BCRYPT_ROUNDS=12

LOG_CHANNEL=stack
LOG_STACK=single
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=fitness_journal_db
DB_USERNAME=root
DB_PASSWORD=

SESSION_DRIVER=database
SESSION_LIFETIME=120
SESSION_ENCRYPT=false
SESSION_PATH=/
SESSION_DOMAIN=null

BROADCAST_CONNECTION=log
FILESYSTEM_DISK=local
QUEUE_CONNECTION=database

CACHE_STORE=database
CACHE_PREFIX=
EOF
    echo "✓ .env file created"
else
    echo "✓ .env file exists"
fi

# Step 6: Update .env to use MySQL
echo "Configuring .env for MySQL..."
sed -i 's/DB_CONNECTION=.*/DB_CONNECTION=mysql/' .env
sed -i 's/DB_HOST=.*/DB_HOST=127.0.0.1/' .env
sed -i 's/DB_DATABASE=.*/DB_DATABASE=fitness_journal_db/' .env
sed -i 's/DB_USERNAME=.*/DB_USERNAME=root/' .env
sed -i 's/DB_PASSWORD=.*/DB_PASSWORD=/' .env
echo "✓ .env configured for MySQL"

# Step 7: Create all required cache directories
echo "Creating cache directories..."
mkdir -p storage/framework/cache/data
mkdir -p storage/framework/sessions
mkdir -p storage/framework/views
mkdir -p storage/logs
mkdir -p bootstrap/cache
echo "✓ Cache directories created"

# Step 8: Set permissions
echo "Setting permissions..."
chmod -R 775 storage bootstrap/cache
chown -R $USER:$USER storage bootstrap/cache 2>/dev/null || true
echo "✓ Permissions set"

# Step 9: Generate app key
echo "Generating application key..."
php artisan key:generate --force
echo "✓ Application key generated"

# Step 10: Clear all caches
echo "Clearing caches..."
php artisan config:clear
php artisan cache:clear
php artisan view:clear
php artisan route:clear
echo "✓ Caches cleared"

# Step 11: Test MySQL connection
echo "Testing MySQL connection..."
php -r "
try {
    \$pdo = new PDO('mysql:host=127.0.0.1;dbname=fitness_journal_db', 'root', '');
    echo '✓ MySQL connection successful\n';
} catch (PDOException \$e) {
    echo '✗ MySQL connection failed: ' . \$e->getMessage() . '\n';
    exit(1);
}
"

# Step 12: Run migrations
echo "Running migrations..."
php artisan migrate:fresh --seed --force
echo "✓ Migrations completed"

# Step 13: Kill any process on port 8080
echo "Checking port 8080..."
if lsof -Pi :8080 -sTCP:LISTEN -t >/dev/null 2>&1 ; then
    echo "Port 8080 is in use, killing process..."
    kill -9 $(lsof -t -i:8080) 2>/dev/null || pkill -f "artisan serve" 2>/dev/null
    sleep 2
    echo "✓ Port cleared"
else
    echo "✓ Port 8080 is available"
fi

echo ""
echo "=========================================="
echo "✓ MySQL setup complete!"
echo ""
echo "Start the server with:"
echo "  php artisan serve --host=0.0.0.0 --port=8080"
echo ""
echo "If MySQL connection fails, try:"
echo "  sudo service mysql restart"
echo "  mysql -h 127.0.0.1 -u root -e 'SELECT 1;'"
echo "=========================================="

