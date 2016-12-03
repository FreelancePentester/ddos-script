#!/bin/bash

function clone(){
	echo "Make sure that you have php 5 installed on your system"
	echo "Cloning latest version of bwapp from Sourceforge"
        wget http://nchc.dl.sourceforge.net/project/bwapp/bWAPP/bWAPP_latest.zip
	unzip bWAPP_latest.zip
	mv bWAPP/ bwapp
	mv bwapp /var/www/html
	rm -rf apache2
	rm -rf evil
	rm  bWAPP_latest.zip
	rm bWAPP_intro.pdf ClientAccessPolicy.xml crossdomain.xml INSTALL.txt README.txt release_notes.txt  
        echo "Setting bwapp configuration"
	sudo chmod -R 777 $webroot/bwapp
        sed -i '2 c $bwapp_WEBROOT = "'$webroot'";' $webroot/bwapp/admin/settings.php
        sed -i '21 c $db_username = "'$uname'";' $webroot/bwapp/admin/settings.php
        sed -i '22 c $db_password = "'$pass'";' $webroot/bwapp/admin/settings.php

        
        echo "bwapp Setup Finished Successfully. Happy hacking and happy learning !"
}


#checking mysql is installed
isMYSQL=$(apt-cache show mysql-server | grep 'Version');
if [[ $isMYSQL == *"No packages found"* ]]; then
	echo -n "MySQL Package Not Found. Do you want to install (Y/N)?"
	read mysql_flag
	if [ $mysql_flag == "Y" ] || [ $mysql_flag == "y" ]; then
		echo "Installing MySQL Server. This might take a while."
		sudo apt-get install mysql-server
	else
		echo "bwapp Setup Terminated. MySQL is a must requirement for bwapp to run"
		exit 0
	fi
else
	echo "MySQL found with "$isMYSQL
fi
#checking apache is installed
isApache=$(apt-cache show apache2 | grep 'Version');
if [[ $isApache == *"No packages found"* ]]; then
        echo -n "Apache Package Not Found. Do you want to install (Y/N)?"
	read apache_flag
	if [ $apache_flag == "Y" ] || [ $apache_flag == "y" ]; then
		echo "Installing Apache. This might take a while."
		sudo apt-get install apache2
	else
		echo "bwapp Setup Terminated. Apache is a must requirement for bwapp to run"
		exit 0
	fi
else
        echo "Apache found with "$isApache
fi

#asserting mysql and apache services
MYSQL=$(pgrep mysql | wc -l);
if [ "$MYSQL" -eq 0 ]; then
        echo "MySQL is down. Starting MySQL Service";
        sudo service mysql start
fi
APACHE=$(pgrep apache | wc -l);
if [ "$APACHE" -eq 0 ]; then
        echo "Apache is down. Starting Apache Service";
        sudo service apache2 start
fi

#configuring mysql and apache for bwapp
echo -n "Enter mysql username : "
read uname
echo -n "Enter mysql password : "
read pass
echo -n "Enter the full web root path : "
read webroot

#cloning latest version of bwapp from  GitHub
if [[ -d $webroot/bwapp ]]; then
	echo -n "Folder "$webroot"/bwapp already exists. Do you want to clean and build a fresh latest copy ? (Y/N)"
	read clean_flag
	if [ $clean_flag == "Y" ] || [ $clean_flag == "y"]; then
		echo "Cleaning up old copy"
		rm -rf $webroot/bwapp
		clone
	else
		echo "bwapp Setup Terminated."
	fi
else
	clone
fi
