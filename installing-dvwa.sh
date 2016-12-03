#!/bin/bash

function clone(){
	echo "Make sure that you have php 5 installed on your system"
	echo "Cloning latest version of DVWA from GitHub"
        git clone https://github.com/ethicalhack3r/DVWA.git $webroot/dvwa
        echo "Setting dvwa configuration"
	sudo chmod -R 777 $webroot/dvwa
        sed -i '2 c $dvwa_WEBROOT = "'$webroot'";' $webroot/dvwa/config/config.inc.php
        sed -i '17 c $_DVWA[ 'db_user' ] = "'$uname'";' $webroot/dvwa/config/config.inc.php
        sed -i '18 c $_DVWA[ 'db_password' ] = "'$pass'";' $webroot/dvwa/config/config.inc.php

        #creating database
        echo "Creating dvwa database"
        mysql -u $uname -p$pass -e "CREATE DATABASE IF NOT EXISTS dvwa"
        echo "dvwa Setup Finished Successfully. Happy hacking and happy learning !"
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
		echo "dvwa Setup Terminated. MySQL is a must requirement for dvwa to run"
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
		echo "dvwa Setup Terminated. Apache is a must requirement for dvwa to run"
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

#configuring mysql and apache for dvwa
echo -n "Enter mysql username : "
read uname
echo -n "Enter mysql password : "
read pass
echo -n "Enter the full web root path : "
read webroot

#cloning latest version of dvwa from  GitHub
if [[ -d $webroot/dvwa ]]; then
	echo -n "Folder "$webroot"/dvwa already exists. Do you want to clean and build a fresh latest copy ? (Y/N)"
	read clean_flag
	if [ $clean_flag == "Y" ] || [ $clean_flag == "y"]; then
		echo "Cleaning up old copy"
		rm -rf $webroot/dvwa
		clone
	else
		echo "dvwa Setup Terminated."
	fi
else
	clone
fi
