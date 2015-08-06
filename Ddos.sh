#!/bin/bash

#some variables
DEFAULT_ROUTE=$(ip route show default | awk '/default/ {print $3}')
IFACE=$(ip route show | awk '(NR == 2) {print $3}')
JAVA_VERSION=`java -version 2>&1 |awk 'NR==1{ gsub(/"/,""); print $3 }'`
MYIP=$(ip route show | awk '(NR == 2) {print $9}')
######## Update Kali
function updatekali {
clear
echo -e "
\033[31m#######################################################\033[m
                Let's Update Kali
\033[31m#######################################################\033[m"
select menusel in "Update sources.list" "Update Kali" "Update and Clean Kali" "Back to Main"; do
case $menusel in
        "Update sources.list")
                
		echo -e "\033[31m====== Adding new sources list and updating ======\033[m"
		echo "" >> /etc/apt/sources.list
		echo '# Security updates ' >> /etc/apt/sources.list
		echo 'deb http://http.kali.org/kali kali main non-free contrib' >> /etc/apt/sources.list
		echo 'deb http://security.kali.org/kali-security kali/updates main contrib non-free' >> /etc/apt/sources.list
		echo 'deb-src http://http.kali.org/kali kali main non-free contrib' >> /etc/apt/sources.list
		echo 'deb-src http://security.kali.org/kali-security kali/updates main contrib non-free' >> /etc/apt/sources.list
		apt-get update
		pause
		clear ;;	
	"Update Kali")
		clear
		echo -e "\033[32mUpdating Kali\033[m"
		#apt-get update && apt-get -y dist-upgrade
		apt-get update && apt-get -y upgrade 
		echo -e "\033[32mDone updating kali\033[m"
		pause
		clear ;;
	
	"Update and Clean Kali")
		clear
		echo -e "\033[32mUpdating and Cleaning Kali\033[m"
		apt-get update && apt-get -y dist-upgrade && apt-get autoremove -y && apt-get -y autoclean
		echo -e "\033[32mDone updating and cleaning kali\033[m" ;;
		
	"Back to Main")
		clear
		mainmenu ;;
		
	*)
		screwup
		updatekali ;;

esac

break

done
}
######## Install Dirs3arch
function installDirs3arch {
if [ ! -f /opt/dirs3arch.py ]; then
	echo -e "\e[1;31mThis option will install dirs3arch!\e[0m"
	echo -e "\e[1;31mHTTP(S) directory/file brute forcer\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing dirs3arch ======\033[m"
				sleep 2
				git clone https://github.com/maurosoria/dirs3arch.git /opt/dirs3arch-master/
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] Dirs3arch already installed !\e[0m"
	fi
}
######### Install VirutalBox
function installvirtualbox {
	echo -e "\e[1;33mThis option will install VirtualBox.\e[0m"
	echo "Do you want to install it ? (Y/N)"
	read install
	if [[ $install = Y || $install = y ]] ; then
			read -p "Are you using a 32bit or 64bit operating system [ENTER: 32 or 64]? " operatingsys
			if [ "$operatingsys" == "32" ]; then 
				echo -e "\e[1;33m[+] Downloading Virtualbox for Debian 32bit\e[0m"
				wget http://download.virtualbox.org/virtualbox/4.3.30/virtualbox-4.3_4.3.30-101610~Debian~wheezy_i386.deb
				echo -e "\e[31m[-] Done with download!\e[0m"
				echo -e "\e[1;33m[+] Installing VirtualBox\e[0m"
				dpkg -i virtualbox-4.3_4.3.30-101610~Debian~wheezy_i386.deb
				rm virtualbox-4.3_4.3.30-101610~Debian~wheezy_i386.deb
				echo -e "\e[34m[-] Done installing VirtualBox on your Kali Linux system!\e[0m"
			else
				echo -e "\e[1;33m[+] Downloading VirtualBox for Debian 64bit\e[0m"
				wget http://download.virtualbox.org/virtualbox/4.3.30/virtualbox-4.3_4.3.30-101610~Debian~wheezy_amd64.deb
				echo -e "\e[31m[-] Done with download!\e[0m"
				echo -e "\e[1;33m[+] Installing VirtualBox\e[0m"
				dpkg -i virtualbox-4.3_4.3.30-101610~Debian~wheezy_amd64.deb
				rm virtualbox-4.3_4.3.30-101610~Debian~wheezy_amd64.deb
				echo -e "\e[34m[-] Done installing VirtualBox on your Kali Linux system!\e[0m"
			fi
		else
			echo -e "\e[34m[-] Ok,maybe later !\e[0m"
		fi
}
#### Bleachbit Installation
function installbleachbit {
	echo -e "\e[1;31mThis option will install Bleachbit!\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
	read install
	if [[ $install = Y || $install = y ]] ; then
		echo -e "\e[31m[+] Installing Bleachbit now!\e[0m"
		apt-get -y install bleachbit 
		echo -e "\e[32m[-] Done Installing Bleachbit!\e[0m"		
	else
		echo -e "\e[32m[-] Ok,maybe later !\e[0m"
	fi	
}
#### GoldenDict Installation
function installGoldendict {
	echo -e "\e[1;31mThis option will install GoldenDict!\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
	read install
	if [[ $install = Y || $install = y ]] ; then
		echo -e "\e[31m[+] Installing GoldenDict now!\e[0m"
		apt-get -y install goldendict 
		echo -e "\e[32m[-] Done Installing goldendict!\e[0m"		
	else
		echo -e "\e[32m[-] Ok,maybe later !\e[0m"
	fi	
}
######## Install Flash
function installflash {
	echo "This will install Flash. Do you want to install it ? (Y/N)"
	read install
	if [[ $install = Y || $install = y ]] ; then
		echo -e "\e[31m[+] Installing Flash now!\e[0m"
		apt-get -y install flashplugin-nonfree
		update-flashplugin-nonfree --install
		echo -e "\e[32m[-] Done Installing Flash!\e[0m"		
	else
		echo -e "\e[32m[-] Ok,maybe later !\e[0m"
	fi
	
	
}
######## Install RecordMyDesktop
function installrecordmydesktop {
	echo "This will install RecordMyDesktop. Do you want to install it ? (Y/N)"
	read install
	if [[ $install = Y || $install = y ]] ; then
		echo -e "\e[31m[+] Installing RecordMyDesktop now!\e[0m"
		apt-get -y install gtk-recordmydesktop
		echo -e "\e[32m[-] Done Installing RecordMyDesktop!\e[0m"		
	else
		echo -e "\e[32m[-] Ok,maybe later !\e[0m"
	fi
	
	
}
######## Install Pinta
function installpinta {
	echo "This will install Pinta (image editor). Do you want to install it ? (Y/N)"
	read install
	if [[ $install = Y || $install = y ]] ; then
		echo -e "\e[31m[+] Installing Pinta now!\e[0m"
		apt-get -y install pinta
		echo -e "\e[32m[-] Done Installing Pinta!\e[0m"		
	else
		echo -e "\e[32m[-] Ok,maybe later !\e[0m"
	fi
	
	
}
######## Install GnomeTweakTool
function installgnometweaktool {
	echo "This will install Gnome Tweak Tools. Do you want to install it ? (Y/N)"
	read install
	if [[ $install = Y || $install = y ]] ; then
		echo -e "\e[31m[+] Installing Gnome Tweak Tool now!\e[0m"
		apt-get -y install gnome-tweak-tool
		echo -e "\e[32m[-] Done Installing Gnome Tweak Tool!\e[0m"		
	else
		echo -e "\e[32m[-] Ok,maybe later !\e[0m"
	fi
	
	
}
######## Install ibus
function installibus {
	echo "This will install ibus. Do you want to install it ? (Y/N)"
	read install
	if [[ $install = Y || $install = y ]] ; then
		echo -e "\e[31m[+] Installing ibus now!\e[0m"
		apt-get -y install ibus && apt-get -y install ibus-unikey
		echo -e "\e[32m[-] Done Installing ibus!\e[0m"		
	else
		echo -e "\e[32m[-] Ok,maybe later !\e[0m"
	fi
	
	
}
######## Install libreoffice
function installlibreoffice {
	echo "This will install libreoffice. Do you want to install it ? (Y/N)"
	read install
	if [[ $install = Y || $install = y ]] ; then
		echo -e "\e[31m[+] Installing libreoffice now!\e[0m"
		apt-get -y install libreoffice
		echo -e "\e[32m[-] Done Installing libreoffice!\e[0m"		
	else
		echo -e "\e[32m[-] Ok,maybe later !\e[0m"
	fi
	
	
}
######## Install knotes
function installknotes {
	echo "This will install knotes. Do you want to install it ? (Y/N)"
	read install
	if [[ $install = Y || $install = y ]] ; then
		echo -e "\e[31m[+] Installing knotes now!\e[0m"
		apt-get -y install knotes
		echo -e "\e[32m[-] Done Installing knotes!\e[0m"		
	else
		echo -e "\e[32m[-] Ok,maybe later !\e[0m"
	fi
	
	
}
# JAVA JDK Update
#################################################################################
function installjava {
	echo -e "\e[1;31mThis option will update your JDK version to jdk1.7.0\e[0m"
	echo -e "\e[1;31mUse this only if java not installed or your version is older than this one!\e[0m"
	echo -e "\e[1;31mYour current Version is : $JAVA_VERSION\e[0m"
	echo "Do you want to install it ? (Y/N)"
	read install
	if [[ $install = Y || $install = y ]] ; then
			read -p "Are you using a 32bit or 64bit operating system [ENTER: 32 or 64]? " operatingsys
			if [ "$operatingsys" == "32" ]; then 
				echo -e "\e[1;31m[+] Downloading and Updating to jdk1.7.0\e[0m"
				echo -e ""
				wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "http://download.oracle.com/otn-pub/java/jdk/7/jdk-7-linux-i586.tar.gz"
				tar zxvf jdk-7-linux-i586.tar.gz
				mv jdk1.7.0 /usr/lib/jvm
				update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.7.0/jre/bin/java 2
				echo -e "\e[1;34mWhen prompted, select option 2\e[0m"
				sleep 2
				echo -e ""
				update-alternatives --config java
				rm jdk-7-linux-i586.tar.gz
				echo -e ""
				echo -e "\e[1;34mYour new JDk version is...\e[0m"
				echo ""
				java -version
				sleep 3
				echo ""
			else
				echo -e "\e[1;31m[+] Downloading and Updating to jdk1.7.0\e[0m"
				echo -e ""
				wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "http://download.oracle.com/otn-pub/java/jdk/7u17-b02/jdk-7u17-linux-x64.tar.gz"
				tar zxvf jdk-7u17-linux-x64.tar.gz
				mv jdk1.7.0_17/ /usr/lib/jvm
				update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.7.0_17/jre/bin/java 2
				echo -e "\e[1;34mWhen prompted, select option 2\e[0m"
				sleep 2
				echo -e ""
				update-alternatives --config java
				rm jdk-7u17-linux-x64.tar.gz
				echo -e ""
				echo -e "\e[1;34mYour new JDk version is...\e[0m"
				echo ""
				java -version
				sleep 3
				echo ""
			fi
		else
			echo -e "\e[32m[-] Ok,maybe later !\e[0m"
		fi

}
######## Install Veil-Framework
function installveil {
if [ ! -f /opt/BypassAV/Veil-Evasion/Veil-Evasion.py ]; then
	echo -e "\e[1;31mThis option will install Veil-Evasion!\e[0m"
	echo -e "\e[1;31mHow to use Veil-Evasopm\e[0m"
	echo -e "\e[1;32mhttps://www.youtube.com/watch?v=8Z4gBKE6i-c\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing Veil-Evasion ======\033[m"
				sleep 2
				git clone https://github.com/Veil-Framework/Veil-Evasion.git /opt/BypassAV/Veil-Evasion/
				cd /opt/BypassAV/Veil-Evasion/setup
				./setup.sh -s
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] Veil-Evasion already installed !\e[0m"
	fi
}
######## Install VPN-BOOK
function installvpnbook {
if [ ! -f /root/Desktop/vpnbook.sh ]; then
	echo -e "\e[1;31mThis option will install VPN-BOOK!\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing VPN-BOOK ======\033[m"
				sleep 2
				cd /root/Desktop
				wget https://github.com/Top-Hat-Sec/thsosrtl/blob/master/VeePeeNee/VeePeeNee.sh
				mv VeePeeNee.sh vpnbook.sh
				chmod a+x vpnbook.sh
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] VPN-BOOK already installed !\e[0m"
	fi
}

######## Install Tor Browser
function installtorbrowser {
if [ ! -f /root/tor-browser_en-US/Browser/start_tor_browser ]; then
	echo -e "\e[1;31mThis option will install Tor Browser!\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing Tor Browser ======\033[m"
				sleep 2
				cd /root/Desktop
				wget https://www.torproject.org/dist/torbrowser/4.5.3/tor-browser-linux32-4.5.3_en-US.tar.xz
				tar -xf tor-browser-linux32-4.5.3_en-US.tar.xz
				cd /root/Desktop/tor-browser_en-US/Browser/
				mv start-tor-browser start-tor-browser.txt
				sed -i 's/`id -u`" -eq 0/`id -u`" -eq 1/g' start-tor-browser.txt
				mv start-tor-browser.txt start-tor-browser
				cd ..
				ls -ld
				chown -R root:root .
				ls -ld
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] Tor Browser already installed !\e[0m"
	fi
}
######## Install VPN
function installvpn {
	echo -e "\e[1;31mThis option will install VPN!\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing VPN ======\033[m"
				sleep 2
				apt-get -y install network-manager-openvpn
				apt-get -y install network-manager-openvpn-gnome
				apt-get -y install network-manager-pptp
				apt-get -y install network-manager-pptp-gnome
				apt-get -y install network-manager-strongswan
				apt-get -y install network-manager-vpnc
				apt-get -y install network-manager-vpnc-gnome
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
}
######## Install Archive-Manager
function installarchivemanager {
	echo -e "\e[1;31mThis option will install Archive Manager!\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing Archive Manager ======\033[m"
				sleep 2
				apt-get -y install unrar unace rar unrar p7zip zip unzip p7zip-full p7zip-rar file-roller
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
}
######## Install Gdebi
function installgdebi {
	echo -e "\e[1;31mThis option will install Gdebi!\e[0m"
	echo -e "\e[1;31mgdebi lets you install local deb packages resolving and installing its dependencies. apt does the same, but only for remote (http, ftp) located packages.!\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing Gdebi ======\033[m"
				sleep 2
				apt-get -y install gdebi &>/dev/nul
				echo -e "\033[32m====== Done Installing Gdebi ======\033[m"
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
}
######## Install bittorrent client
function installbittorrent {
	echo -e "\e[1;31mThis option will install bittorrent!\e[0m"
	echo -e "\e[1;31mThis is a transitional dummy package to ensure clean upgrades from old releases (the package deluge-torrent is replaced by deluge)!\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing bittorrent ======\033[m"
				sleep 2
				apt-get -y install deluge-torrent &>/dev/null
				echo -e "\033[32m====== Done Installing bittorrent ======\033[m"
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
}
######## Install Fix Sound Mute
function installfixsoundmute {
	echo -e "\e[1;31mThis option will fix sound mute on Kali Linux on boot!\e[0m"
	echo -e ""
	echo -e "Do you want to install alsa-utils to fix it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Fixing sound mute ======\033[m"
				sleep 2
				apt-get -y install alsa-utils &>/dev/null
				echo -e "\033[32m====== Done Installing alsa-utils ======\033[m"
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
}
######## Install Change Kali Login Wallpaper
function installchangelogin {
	echo -e "\e[1;31mThis option will change Kali Login Wallpaper!\e[0m"
	echo -e "\e[1;31mPlace wallpaper that you want to make as Kali Login Wallpaper on Desktop\e[0m"
	echo -e "\e[1;31mAfter that, Rename it to "login-background.png" (.png format)\e[0m"
	echo -e ""
	echo -e "Do you want to change it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Changing Kali Login Wallpaper ======\033[m"
				sleep 2
				cd /usr/share/images/desktop-base/
				mv login-backgroung.{png,png.bak}
				mv /root/Desktop/login-background.png /usr/share/images/desktop-base/
				echo -e "\033[32m====== Done Changing ======\033[m"
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
}
######## Install Firefox
function installfirefox {
	echo -e "\e[1;31mThis option will install Firefox!\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing Firefox ======\033[m"
				sleep 2
				apt-get -y remove iceweasel
				echo -e deb http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt all main | tee -a /etc/apt/sources.list > /dev/null
				apt-key adv –recv-keys –keyserver keyserver.ubuntu.com C1289A29
				apt-get update
				apt-get --force-yes install firefox-mozilla-build				
				echo -e "\033[32m====== Done Installing ======\033[m"
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
}
######## Software and System Tools menu
function softwaresandystemtools {
clear
echo -e "
\033[31m#######################################################\033[m
                Software and System Tools
\033[31m#######################################################\033[m"
select menusel in "VirtualBox" "Bleachbit" "GoldenDict" "Flash" "Java" "Pinta" "RecordMyDesktop" "GnomeTweakTool" "ibus" "libreoffice" "knotes" "VPN" "VPN-BOOK" "Tor Browser" "Fix Sound Mute" "Archive-Manager" "Gdebi" "bittorrent client" "Fix Device not managed error" "Change Kali Login Wallpaper" "Firefox" "Install All" "Back to Main"; do
case $menusel in
	"VirtualBox")
		installvirtualbox
		pause
		softwaresandystemtools ;;

	"Firefox")
		installfirefox
		pause
		softwaresandystemtools ;;
		
	"Bleachbit")
		installbleachbit
		pause
		softwaresandystemtools ;;
	
	"GoldenDict")
		installGoldendict
		pause
		softwaresandystemtools ;;
		
	"Flash")
		installflash
		pause
		softwaresandystemtools ;;
		
	"Java")
		installjava
		pause
		softwaresandystemtools ;;
		
	"Pinta")
		installpinta
		pause
		softwaresandystemtools ;;
	"RecordMyDesktop")
		installrecordmydesktop
		pause
		softwaresandystemtools ;;
	"GnomeTweakTool")
		installgnometweaktool
		pause
		softwareandsystemtools ;;
	"ibus")
		installibus
		pause
		softwaresandystemtools ;;
	"libreoffice")
		installlibreoffice
		pause
		softwareandsystemtools ;;
	"knotes")
		installknotes
		pause
		softwaresandystemtools ;;
	"VPN")
		installvpn
		pause
		softwaresandystemtools ;;
	"VPN-BOOK")
		installvpnbook
		pause
		softwaresandystemtools ;;
	"Tor Browser")
		installtorbrowser
		pause
		softwaresandystemtools ;;
	"Fix Sound Mute")
		installfixsoundmute
		pause
		softwaresandystemtools ;;
	"Archive-Manager")
		installarchivemanager
		pause
		softwaresandystemtools ;;
	"Gdebi")
		installgdebi
		pause
		softwaresandystemtools ;;
	"bittorrent client")
		installbittorrent
		pause
		softwaresandystemtools ;;
	"Fix Device not managed error")
		installfixdevice
		pause
		softwaresandystemtools ;;
	"Change Kali Login Wallpaper")
		installchangelogin
		pause
		softwaresandystemtools ;;
	"Install All")
		echo -e "\e[36mJava is install seperately choose it from the Software and System Tools menu\e[0m"
		installvirtualbox
		installbleachbit
		installGoldendict
		installflash
		installpinta
		installrecordmydesktop
		installgnometweaktool
		installibus
		installlibreoffice
		installknotes
		installvpnbook
		installvpn
		installtorbrowser
		installfixsoundmute
		installarchivemanager
		installgdebi
		installbittorrent
		installfixdevice
		installchangelogin
		echo -e "\e[32m[-] Done Installing Software and System Tools\e[0m"
		pause
		softwaresandystemtools ;;

	"Back to Main")
		clear
		mainmenu ;;
		
	*)
		screwup
		softwaresandystemtools ;;
	
		
esac

break

done
}
######## Update metasploit
function updatemetasploit {
if [ ! -f /opt/dirs3arch.py ]; then
	echo -e "\e[1;31mThis option will update latest metasploit version!\e[0m"
	echo -e ""
	echo -e "Do you want to update it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Updating metasploit ======\033[m"
				sleep 2
				git clone https://github.com/rapid7/metasploit-framework.git /opt/exploitation/metasploit/
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] Metasploit already updated !\e[0m"
	fi
}
######## Update Social Engineering Toolkit
function updateSET {
	echo -e "\e[1;31mThis option will update latest SET version!\e[0m"
	echo -e ""
	echo -e "Do you want to update it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Updating SET ======\033[m"
				sleep 2
				rm -rf /opt/exploitation/set/
				git clone https://github.com/trustedsec/social-engineer-toolkit.git /opt/exploitation/set/
				echo -e "\e[32m[-] Done!\e[0m"
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
}
######## Update Beef
function updateBeef {
	echo -e "\e[1;31mThis option will update latest Beef version!\e[0m"
	echo -e "\e[1;31mHow to use BeEF\e[0m"
	echo -e "\e[1;31mhttps://www.youtube.com/playlist?list=PLgmq2kEqEXo-MltlkW0ww7T2Ru1BxN4qm\e[0m"
	echo -e ""
	echo -e "Do you want to update it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Updating SET ======\033[m"
				sleep 2
				git clone https://github.com/beefproject/beef.git /opt/exploitation/beef/
				echo -e "\e[32m[-] Done!\e[0m"
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
}
######## Update Veil-Evasion
function updateVeil {
	echo -e "\e[1;31mThis option will update latest Veil version!\e[0m"
	echo -e ""
	echo -e "Do you want to update it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Updating Veil-Evasion ======\033[m"
				sleep 2
				cd /opt/BypassAV/
				rm -rf Veil-Evasion/
				git clone https://github.com/Veil-Framework/Veil-Evasion.git /opt/BypassAV/Veil-Evasion/
				echo -e "\e[32m[-] Done!\e[0m"
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
}
######## Update Unicorn
function updateVeil {
	echo -e "\e[1;31mThis option will update latest Unicorn version!\e[0m"
	echo -e ""
	echo -e "Do you want to update it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Updating Unicorn ======\033[m"
				sleep 2
				cd /opt/BypassAV/
				rm -rf unicorn-master/
				git clone https://github.com/trustedsec/unicorn.git /opt/BypassAV/unicorn-master/
				echo -e "\e[32m[-] Done!\e[0m"
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
}
######## Update Backdoor Factory
function updateBackdoorFactory {
	echo -e "\e[1;31mThis option will update latest Backdoor Factory version!\e[0m"
	echo -e ""
	echo -e "Do you want to update it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Updating Backdoor Factory ======\033[m"
				sleep 2
				cd /opt/BypassAV/
				rm -rf the-backdoor-factory/
				git clone https://github.com/secretsquirrel/the-backdoor-factory.git /opt/BypassAV/the-backdoor-factory/
				echo -e "\e[32m[-] Done!\e[0m"
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
}
######## Update tools to latest version
function updatetools {
clear
echo -e "
\033[35m#######################################################\033[m
                Update tools to latest version
\033[35m#######################################################\033[m"
select menusel in "Metasploit" "Beef" "Veil-Evasion" "Social Engineering Toolkit" "Backdoor Factory" "Unicorn" "Update All" "Back to Main"; do
case $menusel in
	"Metasploit")
		updatemetasploit
		pause
		updatetools ;;
	"Beef")
		updateBeef
		pause
		updatetools ;;
	"Veil-Evasion")
		updateVeil
		pause
		updatetools ;;
	"Social Engineering Toolkit")
		updateSET
		pause
		updatetools ;;
	"Backdoor Factory")
		updateBackdoorFactory
		pause
		updatetools ;;
	"Unicorn")
		updateUnicorn
		pause
		updatetools ;;
"Update All")
		updatemetasploit
		updateBeef
		updateVeil
		updateSET
		updateBackdoorFactory
		updateUnicorn
		echo -e "\e[32m[-] Done Updating\e[0m"
		pause
		updatetools ;;

	"Back to Main")
		clear
		mainmenu ;;
		
	*)
		screwup
		updatetools ;;
	
		
esac

break

done
}
######## Install Backdoor-Factory
function installbackdoorfactory {
if [ ! -f /opt/BypassAV/the-backdoor-factory/backdoor.py ]; then
	echo -e "\e[1;31mThis option will install Backdoor-Factory!\e[0m"
	echo -e "\e[1;31mPatch PE, ELF, Mach-O binaries with shellcode\e[0m"
		echo -e "\e[1;31mHow to use backdoor-factory\e[0m"
	echo -e "\e[1;32mhttps://www.youtube.com/watch?v=mnmeDfnaq7Q\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing Backdoor Factory ======\033[m"
				sleep 2
				git clone https://github.com/secretsquirrel/the-backdoor-factory.git /opt/BypassAV/the-backdoor-factory/
				cd /opt/BypassAV/the-backdoor-factory/
				./install.sh
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] Backdoor Factory already installed !\e[0m"
	fi
}
######## Install pyobfuscate
function installpyobfuscate {
if [ ! -f /opt/BypassAV/pyobfuscate-master/pyobfuscate.py ]; then
	echo -e "\e[1;31mThis option will install pyobfuscate!\e[0m"
	echo -e "\e[1;31mA pyobfuscate fork made specifically to randomize and obfuscate python based payloads\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing pyobfuscate ======\033[m"
				sleep 2
				git clone https://github.com/byt3bl33d3r/pyobfuscate.git /opt/BypassAV/pyobfuscate-master/
				cd /opt/BypassAV/pyobfuscate-master/
				python setup.py install
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] pyobfuscate already installed !\e[0m"
	fi
}
######## Install Shellter
function installshellter {
if [ ! -f /usr/bin/shellter ]; then
	echo -e "\e[1;31mThis option will install Shellter!\e[0m"
	echo -e "\e[1;31mShellter is a dynamic shellcode injection tool, and probably the first dynamic PE infector ever created.\e[0m"
	echo -e "\e[1;31mHow to use shellter\e[0m"
	echo -e "\e[1;32mhttps://www.youtube.com/watch?v=BIks4iLUI-8\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing Shellter ======\033[m"
				sleep 2
				apt-get -y install shellter
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] Shellter already installed !\e[0m"
	fi
}
######## Install Unicorn
function installunicorn {
if [ ! -f /opt/BypassAV/unicorn-master/unicorn.py ]; then
	echo -e "\e[1;31mThis option will install Unicorn!\e[0m"
	echo -e "\e[1;31mUnicorn is a simple tool for using a PowerShell downgrade attack and inject shellcode straight into memory.\e[0m"
	echo -e "\e[1;31mHow to use unicorn\e[0m"
	echo -e "\e[1;32mhttps://www.youtube.com/watch?v=23irqYIkIig\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing Unicorn ======\033[m"
				sleep 2
				git clone https://github.com/trustedsec/unicorn.git /opt/BypassAV/unicorn-master
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] Unicorn already installed !\e[0m"
	fi
}
######## Install autopwn
function installautopwn {
if [ ! -f /opt/autopwn-master/setup.py ]; then
	echo -e "\e[1;31mThis option will install autopwn!\e[0m"
	echo -e "\e[1;31mSpecify targets and run sets of tools against them\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing autopwn ======\033[m"
				sleep 2
				git clone https://github.com/nccgroup/autopwn.git /opt/autopwn-master/
				cd /opt/autopwn-master/
				pip install -r requirements.txt
				python setup.py install
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] autopwn already installed !\e[0m"
	fi
}
######## Install mitmf
function installmitmf {
if [ ! -f /opt/MITMf-master/mitmf.py ]; then
	echo -e "\e[1;31mThis option will install mitmf!\e[0m"
	echo -e "\e[1;31mFramework for Man-In-The-Middle attacks\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing mitmf ======\033[m"
				sleep 2
				git clone https://github.com/byt3bl33d3r/MITMf.git /opt/MITMf-master/
				cd /opt/MITMf-master
				./kali_setup.sh
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] autopwn already installed !\e[0m"
	fi
}
######## Install commix
function installcommix {
if [ ! -f /opt/commix-master/commix.py ]; then
	echo -e "\e[1;31mThis option will install commix!\e[0m"
	echo -e "\e[1;31mAutomated All-in-One OS Command Injection and Exploitation Tool\e[0m"
	echo -e "\e[1;31mHow to use commix\e[0m"
	echo -e "\e[1;32mhttps://www.youtube.com/watch?v=5bDFLX4-d-8\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing commix ======\033[m"
				sleep 2
				git clone https://github.com/stasinopoulos/commix.git /opt/commix-master/
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] commix already installed !\e[0m"
	fi
}
######## Install EyeWitness
function installeyswitness {
if [ ! -f /opt/EyeWitness-master/EyeWitness.py ]; then
	echo -e "\e[1;31mThis option will install EyeWitness!\e[0m"
	echo -e "\e[1;31mEyeWitness is designed to take screenshots of websites, provide some server header info, and identify default credentials if possible.\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing EyeWitness ======\033[m"
				sleep 2
				git clone https://github.com/ChrisTruncer/EyeWitness.git /opt/EyeWitness-master/
				cd /opt/EyeWitness-master/setup/
				chmod a+x setup.sh
				./setup.sh
				
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] EyeWitness already installed !\e[0m"
	fi
}
######## Install gcat
function installgcat {
if [ ! -f /opt/gcat-master/gcat.py ]; then
	echo -e "\e[1;31mThis option will install gcat!\e[0m"
	echo -e "\e[1;31mA fully featured backdoor that uses Gmail as a C&C server\e[0m"
	echo -e "\e[1;31mHow to use gcat\e[0m"
	echo -e "\e[1;32mhttps://www.youtube.com/watch?v=AI2ZWEwaSd0\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing gcat ======\033[m"
				sleep 2
				git clone https://github.com/byt3bl33d3r/gcat.git /opt/gcat-master/
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] gcat already installed !\e[0m"
	fi
}
######## Install maligno
function installmaligno {
if [ ! -f /opt/BypassAV/maligno/maligno_srv.py ]; then
	echo -e "\e[1;31mThis option will install maligno!\e[0m"
	echo -e "\e[1;31mMaligno is an open source penetration testing tool written in Python that serves Metasploit payloads. It generates shellcode with msfvenom and transmits it over HTTP or HTTPS. The shellcode is encrypted with AES and encoded prior to transmission.\e[0m"
	echo -e "\e[1;31mHow to use Maligno\e[0m"
	echo -e "\e[1;31mhttps://www.youtube.com/watch?v=b57d0IG_gaY\e[om"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing maligno ======\033[m"
				sleep 2
				mkdir /opt/BypassAV/maligno
				cd /opt/BypassAV/maligno
				wget https://www.encripto.no/tools/maligno-2.2.tar.gz
				tar -zxvf maligno-2.2.tar.gz
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] maligno already installed !\e[0m"
	fi
}
######## Install wig
function installwig {
if [ ! -f /opt/wig/wig.py ]; then
	echo -e "\e[1;31mThis option will install wig!\e[0m"
	echo -e "\e[1;31mWebApp Information Gatherer\e[0m"
	echo -e "\e[1;31mHow to use wig\e[0m"
	echo -e "\e[1;32mhttps://www.youtube.com/watch?v=vPVpE54W1KM\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing wig ======\033[m"
				sleep 2
				git clone https://github.com/jekyc/wig.git /opt/wig/
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] wig already installed !\e[0m"
	fi
}
######## Install Windows Exploit Suggester
function installwindowsexploitsuggester {
if [ ! -f /opt/Windows-Exploit-Suggester/windows-exploit-suggester.py ]; then
	echo -e "\e[1;31mThis option will install Windows Exploit Suggester!\e[0m"
	echo -e "\e[1;31mThis tool compares a targets patch levels against the Microsoft vulnerability database in order to detect potential missing patches on the target. It also notifies the user if there are public exploits and Metasploit modules available for the missing bulletins.\e[0m"
	echo -e "\e[1;31mHow to use Windows Exploit Suggester\e[0m"
	echo -e "\e[1;32mhttps://www.youtube.com/watch?v=c-o24mo81CM\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing Windows Exploit Suggester ======\033[m"
				sleep 2
				git clone https://github.com/GDSSecurity/Windows-Exploit-Suggester.git /opt/Windows-Exploit-Suggester/
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] Windows Exploit Suggester already installed !\e[0m"
	fi
}
######## Install shellcode_tools
function installshellcodetools {
if [ ! -f /opt/shellcode_tools-master/shellcode2exe.py ]; then
	echo -e "\e[1;31mThis option will install shellcode tools!\e[0m"
	echo -e "\e[1;31mMiscellaneous tools written in Python, mostly centered around shellcodes.\e[0m"
	echo -e "\e[1;31mHow to use shellcode tools\e[0m"
	echo -e "\e[1;32mhttps://www.youtube.com/watch?v=q_HjKvIEae4\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing Shellcode Tools ======\033[m"
				sleep 2
				git clone https://github.com/MarioVilas/shellcode_tools.git /opt/shellcode_tools-master/
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] Shellcode Tools already installed !\e[0m"
	fi
}
######## Install DAws
function installdaws {
if [ ! -f /opt/DAws-master/DAws.py ]; then
	echo -e "\e[1;31mThis option will install DAws-master!\e[0m"
	echo -e "\e[1;31mAdvanced Web Shell\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing DAws-master ======\033[m"
				sleep 2
				git clone https://github.com/dotcppfile/DAws.git /opt/DAws-master/
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] DAws already installed !\e[0m"
	fi
}
#### pause function
function pause(){
   read -sn 1 -p "Press any key to continue..."
}
######## Install Serbot
function installserbot {
if [ ! -f /opt/Serbot-master/server.py ]; then
	echo -e "\e[1;31mThis option will install Serbot-master!\e[0m"
	echo -e "\e[1;31mAdvanced Controller/Server/Client Reverse Shell/Bot – Windows/Linux – Python\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing Serbot ======\033[m"
				sleep 2
				git clone https://github.com/dotcppfile/Serbot.git /opt/Serbot-master/
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] Serbot already installed !\e[0m"
	fi
}
######## Install Pompem
function installpompem {
if [ ! -f /opt/Pompem-master/pompem.py ]; then
	echo -e "\e[1;31mThis option will install Pompem-master!\e[0m"
	echo -e "\e[1;31mFind exploit tool\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing Pompem ======\033[m"
				sleep 2
				git clone https://github.com/rfunix/Pompem.git /opt/Pompem-master/
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] Pompem already installed !\e[0m"
	fi
}
######## Install LaZagne
function installLazagne {
if [ ! -f /opt/LaZagne-master/README.md ]; then
	echo -e "\e[1;31mThis option will install LaZagne!\e[0m"
	echo -e "\e[1;31mCredentials recovery project\e[0m"
	echo -e "\e[1;31mHow to use LaZagne\e[0m"
	echo -e "\e[1;32mhttps://www.youtube.com/watch?v=QGrBNtjogLE\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing LaZagne ======\033[m"
				sleep 2
				git clone https://github.com/AlessandroZ/LaZagne.git /opt/LaZagne-master/
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] LaZagne already installed !\e[0m"
	fi
}
######## Install Linux Exploit Suggester
function installLinuxexploitsuggester {
if [ ! -f /opt/Linux_Exploit_Suggester-master/Linux_Exploit_Suggester.pl ]; then
	echo -e "\e[1;31mThis option will install Linux Exploit Suggester!\e[0m"
	echo -e "\e[1;31mLinux Exploit Suggester; based on operating system release number\e[0m"
	echo -e "\e[1;31mHow to use Linux Exploit Suggester\e[0m"
	echo -e "\e[1;32mhttps://www.youtube.com/watch?v=Zlf8zEVCGm4\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing Linux Exploit Suggester ======\033[m"
				sleep 2
				git clone https://github.com/PenturaLabs/Linux_Exploit_Suggester.git /opt/Linux_Exploit_Suggester-master/
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
	else
		echo -e "\e[32m[-] Linux Exploit Suggester already installed !\e[0m"
	fi
}
######## Install sparta
function installsparta {
	echo -e "\e[1;31mThis option will install sparta!\e[0m"
	echo -e "\e[1;31mNetwork Infrastructure Penetration Testing Tool.\e[0m"
	echo -e "\e[1;31mHow to use Sparta\e[0m"
	echo -e "\e[1;31mhttp://youtu.be/VgVZMgXvHv4\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing sparta ======\033[m"
				sleep 2
				rm -rf /usr/share/sparta/
				git clone https://github.com/SECFORCE/sparta.git /usr/share/sparta/
				apt-get -y install python-elixir
				apt-get -y install ldap-utils rwho rsh-client x11-apps finger
				cd  /usr/share/
				chmod a+x sparta/
				cd /usr/share/sparta/
				cp sparta /usr/bin/
				cd /usr/bin/
				chmod a+x sparta
				echo -e "\e[32m[-] Done Installing!\e[0m"
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
}
######## Install Avoid
function installavoid {

	echo -e "\e[1;31mThis option will install Avoid!\e[0m"
	echo -e "\e[1;31mMetasploit AV Evasion Tool\e[0m"
	echo -e "\e[1;31mHow to use Avoid\e[0m"
	echo -e "\e[1;32mhttps://www.youtube.com/watch?v=1i5toxB5VpQ\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing Avoid ======\033[m"
				sleep 2
				rm -rf /opt/BypassAV/Avoid/
				git clone https://github.com/nccgroup/metasploitavevasion.git /opt/BypassAV/Avoid/
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
}
######## Install wifite
function installwifite {
	echo -e "\e[1;31mThis option will install wifite!\e[0m"
	echo -e "\e[1;31mAn automated wireless attack tool.\e[0m"
	echo -e "\e[1;31mHow to use wifite\e[0m"
	echo -e "\e[1;31mhttps://www.youtube.com/watch?v=RsBZV96ADrU\e[0m"
	echo -e ""
	echo -e "Do you want to install it ? (Y/N)"
			read install
			if [[ $install = Y || $install = y ]] ; then	
				echo -e "\033[31m====== Installing wifite ======\033[m"
				sleep 2
				rm -rf /opt/Wireless/wifite/
				git clone https://github.com/derv82/wifite.git /opt/Wireless/wifite/
			else
				echo -e "\e[32m[-] Ok,maybe later !\e[0m"
			fi
}
######### Install Hacking Tools
function hackingtools {
clear
echo -e "
\033[31m#######################################################\033[m
                Install Hacking Tools
\033[31m#######################################################\033[m"

select menusel in "Veil-Framework" "Backdoor-Factory" "Shellter" "Unicorn" "avoid" "pyobfuscate" "wifite" "sparta" "Dirs3arch" "autopwn" "mitmf" "commix" "EyeWitness" "gcat" "maligno" "wig" "Windows Exploit Suggester" "Linux Exploit Suggester" "shellcode_tools" "DAws" "Serbot" "Pompem" "LaZagne" "Install All" "Back to Main"; do
case $menusel in
	"Veil-Framework")
		installveil
		pause 
		hackingtools ;;
		
	"wifite")
		installwifite
		pause
		hackingtools ;;
		
	"Backdoor-Factory")
		installbackdoorfactory
		pause
		hackingtools ;;
		
	"avoid")
		installavoid
		pause
		hackingtools ;;
		
	"Shellter")
		installshellter
		pause
		hackingtools ;;
		
	"Unicorn")
		installunicorn
		pause 
		hackingtools ;;
		
	"pyobfuscate")
		installpyobfuscate
		pause 
		hackingtools ;;
		
	"Dirs3arch")
		installDirs3arch
		pause
		hackingtools ;;
		
	"autopwn")
		installautopwn
		pause 
		hackingtools ;;
		
	"mitmf")
		installmitmf
		pause 
		hackingtools ;;
				
	"commix")
		installcommix
		pause 
		hackingtools ;;
	
	"EyeWitness")
		installeyewitness
		pause
		hackingtools  ;;
		
	"gcat")
		installgcat
		pause
		hackingtools  ;;

	"maligno")
		installmaligno
		pause
		hackingtools  ;;
			
	"wig")
		installwig
		pause
		hackingtools ;;
		
	"Windows Exploit Suggester")
		installwindowsexploitsuggester
		pause
		hackingtools ;;

	"Linux Exploit Suggester")
		installLinuxexploitsuggester
		pause
		hackingtools ;;
		
	"shellcode_tools")
		installshellcodetools
		pause
		hackingtools ;;
		
	"DAws")
		installdaws
		pause
		hackingtools ;;
		
	"Serbot")
		installserbot
		pause
		hackingtools ;;
		
	"Pompem")
		installpompem
		pause
		hackingtools ;;
	"LaZagne")
		installLazagne
		pause
		hackingtools ;;
		
	"Install All")
		installveil
		installbackdoorfactory
		installshellter
		installunicorn
		installpyobfuscate
		installDirs3arch
		installautopwn
		installmitmf
		installcommix
		installeyewitness
		installgcat
		installwig
		installwindowsexploitsuggester
		installLinuxexploitsuggester
		installshellcodetools
		installdaws
		installserbot
		installpompem
		installavoid
		installLazagne
		installsparta
		echo -e "\e[32m[-] Done Installing hackingtools\e[0m"
		pause
		extras ;;
		

	"Back to Main")
		clear
		mainmenu ;;
		
	*)
		screwup
		extras ;;
	
		
esac

break

done
}
########################################################
##             Main Menu Section
########################################################
function mainmenu {
echo -e "
\033[32m################################################################################\033[m
\033[1;36m
|                                                                              |
|                          I love Security and Haking.                         |
|______________________________________________________________________________|
|                                                                              |
|                                                                              |
|                                                                              |
|                 User Name:          [   security    ]                        |
|                                                                              |
|                 Password:           [               ]                        |
|                                                                              |
|        My facebook: www.facebook.com/haking.cracking.tutorial                |
|                                                                              |  
|    My youtube channel: www.youtube.com/c/penetrationtestingwithkalilinux     |                                                                      
|                                                                              |
|                                   [ OK ]                                     |
|______________________________________________________________________________|
\033[m                                        
                  	    Script by DDOS
                     	    Version : 2.0.1 \033[32m$version\033[m
Script Location : \033[32m$0\033[m
Connection Info :-----------------------------------------------
  Gateway: \033[32m$DEFAULT_ROUTE\033[m Interface: \033[32m$IFACE\033[m My LAN Ip: \033[32m$MYIP\033[m
\033[32m###############################################################################\033[m"

select menusel in "Update Kali" "Software and System Tools" "Install Hacking Tools" "Update tools to latest version" "Must View" "EXIT PROGRAM"; do
case $menusel in
	"Update Kali")
		updatekali
		clear ;;
	
	"Software and System Tools")
		softwaresandystemtools
		clear ;;
	
	"Install Hacking Tools")
		hackingtools 
		clear ;;
	"Update tools to latest version")
		updatetools
		clear ;;

	"Must View")
		iceweasel https://www.facebook.com/haking.cracking.tutorial
		iceweasel https://www.youtube.com/c/penetrationtestingwithkalilinux
		pause
		clear ;;
	
	"EXIT PROGRAM")
		clear && exit 0 ;;
		
	* )
		screwup
		clear ;;
esac

break

done
}

while true; do mainmenu; done
