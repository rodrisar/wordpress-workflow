#!/bin/bash

# Post provision script

# Activates site

# Apache
cp /home/vagrant/templates/wordpress.apache /etc/apache2/sites-available/wp
cp /home/vagrant/templates/httpd.conf /etc/apache2/conf.d/httpd.conf
a2enmod actions
a2dissite default
a2ensite wp
service apache2 stop

# Nginx

cp /home/vagrant/templates/wordpress.nginx /etc/nginx/sites-available/wp
cp /home/vagrant/templates/www.conf /etc/php5/fpm/pool.d/www.conf
cp /home/vagrant/templates/nginx.conf /etc/nginx/nginx.conf
cp /home/vagrant/templates/nginx.conf /home/vagrant/nginx.conf
ln -s /etc/nginx/sites-available/wp /etc/nginx/sites-enabled/wp
service php5-fpm restart
service nginx restart
export WP_ENV=production
