# GitHub Codespaces Setup Guide

This application is fully configured to work in GitHub Codespaces. Follow these steps:

## Automatic Setup

When you create a Codespace, the setup should run automatically via the `.devcontainer/devcontainer.json` configuration.

## Manual Setup (if needed)

If automatic setup doesn't work, run:

```bash
bash setup.sh
```

## Starting the Application in Codespaces

The application needs to run on port 8080 and bind to 0.0.0.0 to be accessible:

```bash
php artisan serve --host=0.0.0.0 --port=8080
```

## Database Configuration

The `.env` file should have:

```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=fitness_journal_db
DB_USERNAME=root
DB_PASSWORD=
```

## Troubleshooting

### MySQL Connection Issues

If you get authentication errors:

```bash
mysql -h 127.0.0.1 -u root -e "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"
```

### Port Already in Use

If port 8080 is busy:

```bash
php artisan serve --host=0.0.0.0 --port=8081
```

Then update the port forwarding in Codespaces settings.

## Testing

Once running, the application will be available at the forwarded port (usually shown in the Codespaces ports tab).

