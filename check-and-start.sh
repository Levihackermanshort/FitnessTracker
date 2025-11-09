#!/bin/bash

# Check server status and fix port issues

echo "=== Checking Server Status ==="

# Check if server is running
if pgrep -f "artisan serve" > /dev/null; then
    echo "Server is already running!"
    echo "Killing existing server..."
    pkill -f "artisan serve"
    sleep 2
fi

# Check what's using port 8080
echo "Checking port 8080..."
if lsof -Pi :8080 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "Port 8080 is in use by:"
    lsof -i :8080
    echo "Killing process on port 8080..."
    kill -9 $(lsof -t -i:8080) 2>/dev/null
    sleep 2
fi

# Try different ports if 8080 is busy
PORT=8080
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "Port 8080 still busy, trying 8081..."
    PORT=8081
fi

if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "Port 8081 also busy, trying 8082..."
    PORT=8082
fi

echo ""
echo "Starting server on port $PORT..."
echo "Server will be available at: http://0.0.0.0:$PORT"
echo ""
echo "In Codespaces:"
echo "1. Go to the 'Ports' tab"
echo "2. Find port $PORT"
echo "3. Click the globe icon or 'Open in Browser'"
echo ""

php artisan serve --host=0.0.0.0 --port=$PORT

