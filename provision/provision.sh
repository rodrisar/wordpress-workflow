#!/bin/bash

# Wordpress-workflow provisioning script

apt-get update


# Configurations

PACKAGES="php5 mysql-client mysql-server php5-mysql apache2 tree vim curl"
PACKAGES="$PACKAGES nginx-full php5-fpm php5-cgi spawn-fcgi php-pear php5-gd"
PACKAGES="$PACKAGES php-apc php5-curl php5-mcrypt php5-memcached fcgiwrap php5-mcrypt"

APP_TOKEN="/home/vagrant/workflow-documentation/scripts/app_token"
PUBLIC_DIRECTORY="/home/vagrant/public_www"

# Sets mysql pasword
debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'

echo "Installing packages $PACKAGES ..."

apt-get install $PACKAGES --assume-yes

# Makes apache not init in start
update-rc.d -f  apache2 remove
update-rc.d php5-fpm defaults

# Wordpress client and public folder
if [ ! -d "$PUBLIC_DIRECTORY" ]; then
    mkdir $PUBLIC_DIRECTORY
fi

chown -R vagrant $PUBLIC_DIRECTORY
chgrp -R vagrant $PUBLIC_DIRECTORY

echo "Installing wp-cli"
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

Installing composer
curl -sS https://getcomposer.org/installer | php
chmod +x composer.phar
mv composer.phar /usr/local/bin/composer

# Installing squizlabs/php_codesniffer & WordPress-Coding-Standards
composer create-project wp-coding-standards/wpcs:dev-master --no-dev
ln -s /home/vagrant/wpcs/vendor/bin/phpcs /usr/local/bin/phpcs
ln -s /home/vagrant/wpcs/vendor/bin/phpcbf /usr/local/bin/phpcbf

# Generates unique token for application
if [ ! -f "$APP_TOKEN" ]; then
    touch $APP_TOKEN
    echo $RANDOM > $APP_TOKEN
fi

# Copy virtualhost creator (nginx, apache)

cd /usr/local/bin
cp /home/vagrant/provision/virtualhost/virtualhost.sh virtualhost
chmod +x virtualhost
cp /home/vagrant/provision/virtualhost/virtualhost-nginx.sh virtualhost-nginx
chmod +x virtualhost-nginx
cd -
