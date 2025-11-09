#!/bin/bash

# Quick fix script for 500 errors in Codespaces

echo "=== Fixing Codespaces 500 Error ==="

# Step 1: Check Laravel logs
echo "Checking Laravel logs..."
if [ -f storage/logs/laravel.log ]; then
    echo "Last 20 lines of error log:"
    tail -n 20 storage/logs/laravel.log
    echo ""
fi

# Step 2: Clear all caches
echo "Clearing all caches..."
php artisan config:clear
php artisan cache:clear
php artisan view:clear
php artisan route:clear
echo "✓ Caches cleared"

# Step 3: Ensure .env exists
if [ ! -f .env ]; then
    echo "Creating .env file..."
    cat > .env << EOF
APP_NAME="Fitness Tracker"
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_TIMEZONE=UTC
APP_URL=http://localhost

DB_CONNECTION=sqlite
DB_DATABASE=database/database.sqlite

SESSION_DRIVER=file
CACHE_STORE=file
QUEUE_CONNECTION=database
EOF
    echo "✓ .env created"
fi

# Step 4: Generate app key
echo "Generating application key..."
php artisan key:generate --force
echo "✓ App key generated"

# Step 5: Try SQLite (most reliable)
echo "Setting up SQLite database..."
mkdir -p database
touch database/database.sqlite
chmod 664 database/database.sqlite
echo "✓ SQLite database created"

# Step 6: Update .env to use SQLite
sed -i 's/DB_CONNECTION=mysql/DB_CONNECTION=sqlite/' .env 2>/dev/null || \
sed -i 's/DB_CONNECTION=.*/DB_CONNECTION=sqlite/' .env
sed -i 's|DB_DATABASE=.*|DB_DATABASE=database/database.sqlite|' .env
echo "✓ .env updated for SQLite"

# Step 7: Run migrations
echo "Running migrations..."
php artisan migrate:fresh --seed --force
echo "✓ Migrations completed"

# Step 8: Set permissions
echo "Setting permissions..."
chmod -R 775 storage bootstrap/cache
echo "✓ Permissions set"

# Step 9: Final cache clear
php artisan config:clear
echo "✓ Final cache clear"

echo ""
echo "=========================================="
echo "✓ Setup complete!"
echo ""
echo "Start the server with:"
echo "  php artisan serve --host=0.0.0.0 --port=8080"
echo "=========================================="

