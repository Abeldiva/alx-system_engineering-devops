#!/bin/bash
# Update package list
# Install Nginx if not already installed
# Backup existing Nginx configuration
# Create a new Nginx configuration file to listen on port 80
# Test Nginx configuration for syntax errors
# Reload Nginx to apply changes
# Ensure Nginx is enabled and running
# Check if Nginx is listening on port 80

apt-get update

if ! dpkg -l | grep -q nginx; then
    apt-get install -y nginx
fi

if [ -f /etc/nginx/sites-available/default ]; then
    cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
fi

cat <<EOL > /etc/nginx/sites-available/default
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html;

    server_name _;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOL

nginx -t

if [ $? -ne 0 ]; then
    echo "Nginx configuration test failed."
    exit 1
fi

systemctl reload nginx

systemctl enable nginx
systemctl start nginx

ss -tuln | grep ':80'

if [ $? -ne 0 ]; then
    echo "Nginx is not listening on port 80."
    exit 1
fi

echo "Nginx is successfully configured to listen on port 80."
