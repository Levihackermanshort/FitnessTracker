# GitHub Codespaces - Quick Start Commands

Copy and paste these commands in your Codespaces terminal:

## Step 1: Navigate to project directory (if needed)
```bash
cd FitnessTracker
```

## Step 2: Configure MySQL Authentication
```bash
mysql -h 127.0.0.1 -u root -e "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"
```

If that doesn't work, try:
```bash
mysql -h 127.0.0.1 -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"
```

## Step 3: Create Database
```bash
mysql -h 127.0.0.1 -u root -e "CREATE DATABASE IF NOT EXISTS fitness_journal_db;"
```

## Step 4: Install Composer Dependencies
```bash
composer install --no-interaction
```

## Step 5: Generate Application Key
```bash
php artisan key:generate
```

## Step 6: Verify .env File
Make sure your `.env` file has:
```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=fitness_journal_db
DB_USERNAME=root
DB_PASSWORD=
```

## Step 7: Run Migrations and Seeders
```bash
php artisan migrate:fresh --seed
```

## Step 8: Clear Caches
```bash
php artisan config:clear
php artisan cache:clear
php artisan view:clear
```

## Step 9: Start the Server (IMPORTANT: Use port 8080 for Codespaces)
```bash
php artisan serve --host=0.0.0.0 --port=8080
```

## Alternative: Use the Setup Script
Instead of steps 2-8, you can run:
```bash
bash setup.sh
```

Then start the server:
```bash
php artisan serve --host=0.0.0.0 --port=8080
```

## Quick One-Liner (if setup.sh works)
```bash
bash setup.sh && php artisan serve --host=0.0.0.0 --port=8080
```

## Troubleshooting

### If MySQL connection fails:
```bash
# Check if MySQL is running
sudo service mysql status

# Start MySQL if needed
sudo service mysql start

# Try connecting
mysql -h 127.0.0.1 -u root -e "SELECT 1;"
```

### If port 8080 is busy:
```bash
# Use a different port (then update port forwarding in Codespaces)
php artisan serve --host=0.0.0.0 --port=8081
```

### If you get permission errors:
```bash
chmod -R 775 storage bootstrap/cache
```

### Check if everything is set up correctly:
```bash
php artisan about
```

## Access the Application

After starting the server, GitHub Codespaces will automatically forward port 8080.
- Look for the "Ports" tab in the bottom panel
- Click on the forwarded port URL to open the application
- Or use the popup notification that appears

The application will be available at the forwarded URL (something like: `https://xxxx-8080.app.github.dev`)

