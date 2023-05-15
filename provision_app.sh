#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y

# Install nginx web server
sudo apt-get install nginx -y

# Start nginx web server 
sudo systemctl start nginx

# Display nginx web server status to check it is running
sudo systemctl status nginx

# Install app dependencies
sudo apt-get install python-software-properties
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install nodejs -y
sudo npm install pm2 -g

# Add database host IP info to .bashrc
echo -e "\nexport DB_HOST=mongodb://192.168.10.150:27017/posts" | sudo tee -a .bashrc
source .bashrc

# Copy the configuration file to setup reverse proxy
sudo cp /home/vagrant/nginx_config/default /etc/nginx/sites-available/default
sudo systemctl restart nginx

# Install npm in app directory and run the app
cd app
sudo npm install
node seeds/seed.js
node app.js