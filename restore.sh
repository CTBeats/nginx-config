#!/bin/bash

# CTBeats nginx config restore script
# Usage: sudo ./restore.sh

set -e

BACKUP_DIR="/etc/nginx"

if [ ! -f /etc/nginx/nginx.conf ]; then
    echo "ERROR: /etc/nginx/nginx.conf not found. Run as root on the server."
    exit 1
fi

echo "Restoring nginx configuration..."

# Back up existing configs
if [ -d /etc/nginx/sites-available ]; then
    cp -r /etc/nginx/sites-available /etc/nginx/sites-available.bak
fi
if [ -d /etc/nginx/conf.d ]; then
    cp -r /etc/nginx/conf.d /etc/nginx/conf.d.bak
fi

sudo cp "$(dirname "$0")/nginx.conf" /etc/nginx/nginx.conf
sudo cp "$(dirname "$0")/sites-available/"* /etc/nginx/sites-available/
sudo cp "$(dirname "$0")/conf.d/default.conf" /etc/nginx/conf.d/default.conf

# Set ownership and permissions
sudo chown root:root /etc/nginx/nginx.conf /etc/nginx/sites-available/* /etc/nginx/conf.d/default.conf
sudo chmod 644 /etc/nginx/nginx.conf /etc/nginx/sites-available/* /etc/nginx/conf.d/default.conf
sudo chmod 755 /etc/nginx/sites-available

# Re-create sites-enabled symlinks
sudo rm -f /etc/nginx/sites-enabled/*
for f in /etc/nginx/sites-available/*; do
    name=$(basename "$f")
    sudo ln -sf "/etc/nginx/sites-available/$name" "/etc/nginx/sites-enabled/$name"
done

echo "nginx configuration restored."
echo "Testing nginx config..."
sudo nginx -t
echo "Reloading nginx..."
sudo systemctl reload nginx

echo "Restore complete."
