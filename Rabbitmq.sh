#!/bin/bash
# Update and install RabbitMQ
echo "Installing RabbitMQ..."
apt update -y
apt install -y curl gnupg apt-transport-https software-properties-common

curl -fsSL https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey | gpg --dearmor | tee /usr/share/keyrings/com.rabbitmq.team.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/com.rabbitmq.team.gpg] https://packagecloud.io/rabbitmq/rabbitmq-server/ubuntu/ jammy main" | tee /etc/apt/sources.list.d/rabbitmq.list

apt update -y
apt install -y rabbitmq-server

# Enable service
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

# Configure user
echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config
rabbitmqctl add_user test test
rabbitmqctl set_user_tags test administrator
rabbitmqctl set_permissions -p / test ".*" ".*" ".*"

# Enable management UI
rabbitmq-plugins enable rabbitmq_management

# Firewall
ufw allow 5672/tcp
ufw allow 15672/tcp

echo "RabbitMQ setup complete. Access UI on http://<Public-IP>:15672 (user: test / pass: test)"
