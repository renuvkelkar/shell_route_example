#!/bin/bash

# GoRouter ShellRoute Demo - Web Runner Script
echo "Starting GoRouter ShellRoute Demo..."
echo "This will start a Flutter web server on port 8080"
echo "Open your browser and navigate to: http://localhost:8080"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Run Flutter web app
flutter run -d web-server --web-port 8080
