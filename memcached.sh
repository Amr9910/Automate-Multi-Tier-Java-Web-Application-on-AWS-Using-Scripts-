#!/bin/bash
# Update and install Memcached
echo "Installing Memcached..."
apt update -y
apt install -y memcached

# Configure to listen on all interfaces
sed -i 's/-l 127.0.0.1/-l 0.0.0.0/g' /etc/memcached.conf

# Restart service
systemctl restart memcached
systemctl enable memcached

# Firewall
ufw allow 11211/tcp
ufw allow 11211/udp

echo "Memcached setup complete."
