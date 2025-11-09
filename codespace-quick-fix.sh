#!/bin/bash

# Complete fix for Codespaces - Use SQLite (most reliable)

echo "=== Fixing Codespaces Setup ==="

# Step 1: Create .env file if it doesn't exist
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

DB_CONNECTION=sqlite
DB_DATABASE=database/database.sqlite

SESSION_DRIVER=file
SESSION_LIFETIME=120
SESSION_ENCRYPT=false
SESSION_PATH=/
SESSION_DOMAIN=null

BROADCAST_CONNECTION=log
FILESYSTEM_DISK=local
QUEUE_CONNECTION=database

CACHE_STORE=file
CACHE_PREFIX=
EOF
    echo "✓ .env file created"
else
    echo "✓ .env file exists"
fi

# Step 2: Update .env to use SQLite
echo "Configuring for SQLite..."
sed -i 's/DB_CONNECTION=.*/DB_CONNECTION=sqlite/' .env
sed -i 's|DB_DATABASE=.*|DB_DATABASE=database/database.sqlite|' .env
echo "✓ Database configured for SQLite"

# Step 3: Create SQLite database
echo "Creating SQLite database..."
mkdir -p database
touch database/database.sqlite
chmod 664 database/database.sqlite
echo "✓ SQLite database created"

# Step 4: Generate app key
echo "Generating application key..."
php artisan key:generate --force
echo "✓ Application key generated"

# Step 5: Clear all caches
echo "Clearing caches..."
php artisan config:clear
php artisan cache:clear
php artisan view:clear
php artisan route:clear
echo "✓ Caches cleared"

# Step 6: Run migrations
echo "Running migrations..."
php artisan migrate:fresh --seed --force
echo "✓ Migrations completed"

# Step 7: Set permissions
echo "Setting permissions..."
chmod -R 775 storage bootstrap/cache
echo "✓ Permissions set"

# Step 8: Kill any process on port 8080
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
echo "✓ Setup complete!"
echo ""
echo "Start the server with:"
echo "  php artisan serve --host=0.0.0.0 --port=8080"
echo ""
echo "Or use a different port if 8080 is busy:"
echo "  php artisan serve --host=0.0.0.0 --port=8081"
echo "=========================================="

