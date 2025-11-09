# Troubleshooting 500 Error in Codespaces

## Step 1: Check Laravel Logs
```bash
tail -n 50 storage/logs/laravel.log
```

This will show you the exact error. Common issues:

## Step 2: Fix MySQL Connection

### Option A: Try SQLite First (Quick Test)
```bash
# Update .env to use SQLite temporarily
sed -i 's/DB_CONNECTION=mysql/DB_CONNECTION=sqlite/' .env
sed -i 's/DB_DATABASE=fitness_journal_db/DB_DATABASE=database\/database.sqlite/' .env

# Create SQLite database
touch database/database.sqlite

# Run migrations
php artisan migrate:fresh --seed

# Clear caches
php artisan config:clear
php artisan cache:clear

# Restart server
php artisan serve --host=0.0.0.0 --port=8080
```

### Option B: Fix MySQL Connection
```bash
# Check if MySQL is running
sudo service mysql status

# Start MySQL if needed
sudo service mysql start

# Try different MySQL connection methods
mysql -h 127.0.0.1 -u root -e "SELECT 1;" || \
mysql -h localhost -u root -e "SELECT 1;" || \
mysql -u root -e "SELECT 1;"

# Configure authentication (try all variations)
mysql -h 127.0.0.1 -u root -e "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;" 2>/dev/null
mysql -h 127.0.0.1 -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;" 2>/dev/null
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;" 2>/dev/null

# Create database
mysql -h 127.0.0.1 -u root -e "CREATE DATABASE IF NOT EXISTS fitness_journal_db;" || \
mysql -u root -e "CREATE DATABASE IF NOT EXISTS fitness_journal_db;"

# Update .env with correct host
# Try: DB_HOST=127.0.0.1
# Or: DB_HOST=localhost
```

## Step 3: Verify .env File
```bash
# Check if .env exists
cat .env | grep DB_

# Should show:
# DB_CONNECTION=mysql
# DB_HOST=127.0.0.1
# DB_PORT=3306
# DB_DATABASE=fitness_journal_db
# DB_USERNAME=root
# DB_PASSWORD=
```

## Step 4: Complete Reset
```bash
# Clear everything
php artisan config:clear
php artisan cache:clear
php artisan view:clear
php artisan route:clear

# Recreate .env if needed
cp .env.example .env 2>/dev/null || echo "APP_KEY=" >> .env

# Generate key
php artisan key:generate

# Set permissions
chmod -R 775 storage bootstrap/cache

# Try SQLite (most reliable in Codespaces)
echo "DB_CONNECTION=sqlite" >> .env
echo "DB_DATABASE=database/database.sqlite" >> .env
touch database/database.sqlite
php artisan migrate:fresh --seed
php artisan config:clear
php artisan serve --host=0.0.0.0 --port=8080
```

## Step 5: Check PHP Extensions
```bash
php -m | grep -i mysql
php -m | grep -i pdo
```

If missing, install:
```bash
sudo apt-get update
sudo apt-get install -y php-mysql php-pdo
```

