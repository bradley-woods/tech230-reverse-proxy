#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y

# Install nginx web server
sudo apt-get install nginx -y

# Start nginx web server 
sudo systemctl start nginx

# Modify the configuration file to setup reverse proxy
sudo sed "s/_;/192.168.10.100;/" /etc/nginx/sites-available/default
sudo sed "s/# First attempt to serve request as file, then/proxy_pass http:\/\/localhost:3000;/" /etc/nginx/sites-available/default


sudo systemctl nginx restart

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

# Install npm in app directory and run the app
cd app
sudo npm install
node seeds/seed.js
node app.js