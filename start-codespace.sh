#!/bin/bash

# Quick start script for GitHub Codespaces
# Run this after the initial setup

echo "Starting Fitness Tracker in Codespace..."

# Clear caches
php artisan config:clear
php artisan cache:clear
php artisan view:clear

# Ensure database exists
mysql -h 127.0.0.1 -u root -e "CREATE DATABASE IF NOT EXISTS fitness_journal_db;" 2>/dev/null || \
mysql -u root -e "CREATE DATABASE IF NOT EXISTS fitness_journal_db;" 2>/dev/null || \
echo "Database check completed"

# Run migrations if needed
php artisan migrate --force

# Start server on port 8080 (Codespaces default)
echo ""
echo "=========================================="
echo "Starting Laravel server on port 8080..."
echo "Application will be available at the forwarded port"
echo "=========================================="
echo ""

php artisan serve --host=0.0.0.0 --port=8080

