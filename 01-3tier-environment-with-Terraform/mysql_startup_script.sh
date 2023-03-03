#!/bin/bash

# Install MySQL Server
apt-get update
apt-get install -y mysql-server

# Configure MySQL Server
sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Restart MySQL Server
systemctl restart mysql

# Create Database and User
mysql -uroot -e "CREATE DATABASE myapp;"
mysql -uroot -e "CREATE USER 'myappuser'@'%' IDENTIFIED BY 'mypassword';"
mysql -uroot -e "GRANT ALL PRIVILEGES ON myapp.* TO 'myappuser'@'%';"

# Install and Configure Monitoring Agent (Optional)
apt-get install -y prometheus-mysqld-exporter
echo "collectors:\n  - mysqld_exporter" >> /etc/prometheus/prometheus.yml
systemctl restart prometheus
