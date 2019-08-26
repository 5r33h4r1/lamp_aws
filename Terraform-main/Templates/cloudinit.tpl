#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update -y
sudo echo "Test file" > /home/ubuntu/test.txt
sudo apt-get install apache2 -y
sudo systemctl start apache2
echo "Hello World" > /var/www/html/index.html


# Install PHP

sudo apt-get -y install software-properties-common
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update
sudo apt-get install -y php5.6
sudo echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/phpinfo.php
sudo chown www-data:www-data /var/www/html/phpinfo.php
sudo chmod 755 /var/www/html/phpinfo.php


# Install MySQL 
# Install essential packages
apt-get -y install zsh htop

# Install MySQL Server in a Non-Interactive mode. Default root password will be "root"
echo "mysql-server-5.7 mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server-5.7 mysql-server/root_password_again password root" | sudo debconf-set-selections
apt-get -y install mysql-server-5.7


