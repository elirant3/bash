#!/usr/bin/bash

echo "Website Name:" 
read name

sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/$name.conf
sudo echo "<VirtualHost *:80>
	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/html/$name/public_html

	ServerName $name
        ServerAlias www.$name

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

	<Directory /var/www/html/$name/public_html>
		Options Indexes FollowSymLinks MultiViews
		AllowOverride All
		Require all granted
	</Directory>
</VirtualHost>" > /etc/apache2/sites-available/$name.conf

sudo echo "192.168.14.57	$name" | cat - /etc/hosts > temp && mv temp /etc/hosts

sudo a2ensite $name

sudo systemctl restart apache2


