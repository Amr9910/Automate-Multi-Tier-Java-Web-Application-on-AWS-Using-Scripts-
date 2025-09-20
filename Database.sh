#!/bin/bash
# Update and install MariaDB
echo "Installing MariaDB..."
apt update -y
apt install -y mariadb-server git expect

# Start MariaDB
systemctl start mariadb
systemctl enable mariadb

# Secure installation automatically
echo "Securing MariaDB..."
expect <<EOF
spawn mysql_secure_installation
expect "Enter current password for root (enter for none):"
send "\r"
expect "Switch to unix_socket authentication \[Y/n\]"
send "n\r"
expect "Change the root password? \[Y/n\]"
send "y\r"
expect "New password:"
send "admin123\r"
expect "Re-enter new password:"
send "admin123\r"
expect "Remove anonymous users? \[Y/n\]"
send "y\r"
expect "Disallow root login remotely? \[Y/n\]"
send "y\r"
expect "Remove test database and access to it? \[Y/n\]"
send "y\r"
expect "Reload privilege tables now? \[Y/n\]"
send "y\r"
expect eof
EOF

# Create DB + user
echo "Configuring MariaDB database and user..."
mysql -u root -padmin123 <<MYSQL_SCRIPT
CREATE DATABASE accounts;
GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'%' IDENTIFIED BY 'admin123';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Import sample schema
git clone -b main https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
mysql -u root -padmin123 accounts < src/main/resources/db_backup.sql

# Firewall
ufw allow 3306/tcp

echo "MariaDB setup is complete."
