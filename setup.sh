#!/bin/bash

# Setup script for Fitness Tracker
# This script sets up the Laravel application for easy deployment
# Works in both local environments and GitHub Codespaces

echo "Setting up Fitness Tracker..."

# 1) Install PHP + MySQL (if not already installed)
echo "Checking PHP and MySQL installation..."
php --version
mysql --version || echo "MySQL client not found, but may be available via service"

# 2) Start MySQL (if running as service)
echo "Starting MySQL service..."
if command -v service &> /dev/null; then
    sudo service mysql start || echo "MySQL service may already be running or not available as service"
elif command -v systemctl &> /dev/null; then
    sudo systemctl start mysql || echo "MySQL service may already be running"
else
    echo "MySQL should be running via Codespaces service"
fi

# 3) Allow PHP to connect as root with empty password (matches config/database.php)
echo "Configuring MySQL for root access..."
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;" 2>/dev/null || \
mysql -u root -e "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;" 2>/dev/null || \
echo "MySQL user configuration may already be set or using different auth method"

# 4) Create database
echo "Creating database..."
mysql -u root -e "CREATE DATABASE IF NOT EXISTS fitness_journal_db;" || \
mysql -h 127.0.0.1 -u root -e "CREATE DATABASE IF NOT EXISTS fitness_journal_db;" || \
echo "Database may already exist"

# 5) Install Composer dependencies
echo "Installing Composer dependencies..."
composer install --no-interaction

# 6) Generate application key (if not already set)
echo "Generating application key..."
php artisan key:generate --force

# 7) Run migrations and seeders
echo "Running migrations and seeders..."
php artisan migrate:fresh --seed

# 8) Set permissions
echo "Setting storage and cache permissions..."
chmod -R 775 storage bootstrap/cache

# 9) Clear caches
echo "Clearing application caches..."
php artisan config:clear
php artisan cache:clear
php artisan view:clear

echo ""
echo "=========================================="
echo "Setup complete!"
echo ""
echo "To start the application:"
echo "  php artisan serve --host=0.0.0.0 --port=8080"
echo ""
echo "Or for local development:"
echo "  php artisan serve"
echo "=========================================="
