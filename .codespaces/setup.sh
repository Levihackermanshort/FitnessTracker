#!/bin/bash

# GitHub Codespaces specific setup
# This runs automatically when Codespace is created

echo "Setting up Fitness Tracker in GitHub Codespaces..."

# Install MySQL client if not present
if ! command -v mysql &> /dev/null; then
    echo "Installing MySQL client..."
    sudo apt-get update
    sudo apt-get install -y mysql-client
fi

# The MySQL service should already be running in Codespaces
# Just need to configure it

# Configure MySQL for PHP connection
mysql -h 127.0.0.1 -u root -e "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;" 2>/dev/null || \
mysql -h 127.0.0.1 -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;" 2>/dev/null || \
echo "MySQL authentication already configured"

# Create database
mysql -h 127.0.0.1 -u root -e "CREATE DATABASE IF NOT EXISTS fitness_journal_db;" || \
echo "Database may already exist"

# Run main setup
bash setup.sh

