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

# Create the ERPNext database and user
sudo mysql -e "CREATE DATABASE erpnext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "CREATE USER 'erpnext'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON erpnext.* TO 'erpnext'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Clone the ERPNext repository
git clone https://github.com/frappe/erpnext.git --branch version-14 --depth 1
cd erpnext

# Install Python dependencies
pip3 install -r requirements.txt

# Setup development mode
bench init --frappe-branch version-14 --python python3 --dev

# Configure site
cd frappe-bench
bench set-config site_config.json "db_name" "erpnext"
bench set-config site_config.json "db_password" "password"

# Install ERPNext
bench --site erpnext install-app erpnext

# Start the development server
bench start
