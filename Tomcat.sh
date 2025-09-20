#!/bin/bash
# Run as root (or use sudo)

# Update & Install Dependencies 
echo "Updating system and installing Java, Git, Maven, and Wget..."
apt update -y
apt install -y openjdk-11-jdk git maven wget firewalld

#  Setup Tomcat 
echo "Downloading and extracting Tomcat package..."
cd /tmp/
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.75/bin/apache-tomcat-9.0.75.tar.gz
tar xzvf apache-tomcat-9.0.75.tar.gz

echo "Adding tomcat user..."
useradd --home-dir /usr/local/tomcat --shell /sbin/nologin tomcat

echo "Copying Tomcat files..."
mkdir -p /usr/local/tomcat
cp -r /tmp/apache-tomcat-9.0.75/* /usr/local/tomcat/
chown -R tomcat:tomcat /usr/local/tomcat

echo "Creating tomcat systemd service..."
cat <<EOL > /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
Environment="CATALINA_PID=/usr/local/tomcat/temp/tomcat.pid"
Environment="CATALINA_HOME=/usr/local/tomcat"
Environment="CATALINA_BASE=/usr/local/tomcat"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

ExecStart=/usr/local/tomcat/bin/startup.sh
ExecStop=/usr/local/tomcat/bin/shutdown.sh

Restart=on-failure

[Install]
WantedBy=multi-user.target
EOL

echo "Reloading systemd and starting Tomcat..."
systemctl daemon-reload
systemctl enable tomcat
systemctl start tomcat

# Firewall 
echo "Configuring firewall for Tomcat..."
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --reload

# Deploy Application
echo "Cloning source code..."
cd /home/ubuntu
git clone -b main https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project

echo "Updating application.properties..."
sed -i 's|backend.server.url=.*|backend.server.url=http://db01:3306|' src/main/resources/application.properties

echo "Building project with Maven..."
mvn clean install

echo "Deploying WAR to Tomcat..."
systemctl stop tomcat
rm -rf /usr/local/tomcat/webapps/ROOT*
cp target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
chown -R tomcat:tomcat /usr/local/tomcat/webapps
systemctl start tomcat

echo "Tomcat setup and deployment is complete on Ubuntu!"
