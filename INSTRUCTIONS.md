# Instructions for Running Fitness Tracker

## For Teachers/Assessors

### Quick Setup (Recommended)

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd AdvancedWeb-Laravel
   ```

2. **Run the setup script**
   ```bash
   bash setup.sh
   ```

   This script will:
   - Check PHP and MySQL installation
   - Configure MySQL authentication
   - Create the database
   - Install dependencies
   - Generate application key
   - Run migrations and seeders
   - Set proper permissions

3. **Start the application**
   ```bash
   php artisan serve
   ```

4. **Access the application**
   - Open browser to: `http://localhost:8000`
   - Or: `http://127.0.0.1:8000`

### Manual Setup (if script fails)

1. **Install dependencies**
   ```bash
   composer install
   ```

2. **Configure environment**
   - Ensure `.env` file exists (copy from `.env.example` if needed)
   - Verify database settings:
     ```
     DB_CONNECTION=mysql
     DB_HOST=127.0.0.1
     DB_PORT=3306
     DB_DATABASE=fitness_journal_db
     DB_USERNAME=root
     DB_PASSWORD=
     ```

3. **Configure MySQL**
   ```bash
   mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"
   mysql -u root -e "CREATE DATABASE IF NOT EXISTS fitness_journal_db;"
   ```

4. **Generate application key**
   ```bash
   php artisan key:generate
   ```

5. **Run migrations and seeders**
   ```bash
   php artisan migrate:fresh --seed
   ```

6. **Start server**
   ```bash
   php artisan serve
   ```

## For GitHub Codespaces

1. **Open repository in Codespace**
   - Click "Code" → "Codespaces" → "Create codespace"

2. **Setup runs automatically** via `.devcontainer/devcontainer.json`

3. **If manual setup needed:**
   ```bash
   bash setup.sh
   ```

4. **Start application:**
   ```bash
   php artisan serve --host=0.0.0.0 --port=8080
   ```

5. **Access via forwarded port** (shown in Codespaces ports tab)

## Testing the Application

After setup, you can test:

- **View all workouts**: Navigate to `/workouts` or root URL
- **Create workout**: Click "Add Workout" button
- **Search**: Use search box to filter workouts
- **Edit**: Click "Edit" on any workout
- **View details**: Click "View" on any workout
- **Delete**: Click "Delete" on any workout
- **Pagination**: Navigate through multiple pages if more than 10 workouts

## Troubleshooting

### MySQL Connection Error

If you see authentication errors:
```bash
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"
```

Or for Codespaces:
```bash
mysql -h 127.0.0.1 -u root -e "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"
```

### Database Doesn't Exist

```bash
mysql -u root -e "CREATE DATABASE IF NOT EXISTS fitness_journal_db;"
```

### Clear Caches

```bash
php artisan config:clear
php artisan cache:clear
php artisan view:clear
```

### Permission Issues

```bash
chmod -R 775 storage bootstrap/cache
```

## Requirements Met

✅ Laravel 11 framework  
✅ MySQL/MariaDB database  
✅ Single table design (workouts)  
✅ Migrations and seeders  
✅ Full CRUD operations  
✅ Search functionality  
✅ Pagination  
✅ Laravel validation  
✅ CSS styling for 1366x768  
✅ No authentication  
✅ No JavaScript  
✅ No CSS frameworks  
✅ Comprehensive README

