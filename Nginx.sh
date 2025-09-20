#!/bin/bash
# Update and install Nginx
echo "Installing Nginx..."
apt update -y
apt install -y nginx

# Configure reverse proxy to Tomcat (replace PRIVATE_IP with Tomcat VM IP)
cat <<EOL > /etc/nginx/sites-available/vproapp
upstream vproapp {
    server 172.31.xx.xx:8080;   # Replace with Tomcat VM Private IP
}
server {
    listen 80;
    location / {
        proxy_pass http://vproapp;
    }
}
EOL

# Remove default config
rm -f /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp

# Test config and restart
nginx -t
systemctl restart nginx

echo "Nginx setup complete. Access app via http://<Public-IP>"
