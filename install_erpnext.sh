#!/bin/bash

# Update the system
sudo apt update
sudo apt upgrade -y

# Install dependencies
sudo apt install -y python3-pip python3-dev libssl-dev libffi-dev build-essential

# Install Node.js
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs

# Install wkhtmltopdf
sudo apt install -y wkhtmltopdf

# Install and configure MariaDB
sudo apt install -y mariadb-server
sudo mysql_secure_installation

# Configure MySQL for Frappe
sudo tee -a /etc/mysql/my.cnf << EOF

[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci

[mysql]
default-character-set = utf8mb4
EOF

# Restart MySQL service
sudo service mysql restart

# Create the ERPNext database and user
sudo mysql -e "CREATE DATABASE erpnext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "CREATE USER 'erpnext'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON erpnext.* TO 'erpnext'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Clone the ERPNext repository
git clone https://github.com/frappe/bench.git --depth 1
sudo pip3 install -e bench/

# Setup development mode
bench init frappe-bench --frappe-branch version-14 --python python3 --ignore-exist
cd frappe-bench

# Install ERPNext
bench --site erpnext install-app erpnext

# Start the development server
bench start
