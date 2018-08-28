#!/bin/bash

# Video_Tool installer

	# author : Hessam Ashari
	# gitlab : https://gitlab.com/hessam.ashari/video-tool
	# github : https://github.com/hessamashari/video-tool
	# Email  : hessam.ashari@gmail.com

clear

normal="$(printf '\033[0m')"          # Text mode
# Colors
red="$(printf '\033[0;31m')"  		  # red
green="$(printf '\033[0;32m')"        # green
orange="$(printf '\033[0;33m')"       # orange
blue="$(printf '\033[0;34m')"         # blue
white="$(printf '\033[0;37m')"        # white

echo -e "\n"
echo "+-------------------------------------------------------------------------------+"
echo "|          Usefull commands used for videos are in a project                    |"
echo "|          Author: Hessam Ashari                                                |"
echo "|          Git repository: https://github.com/hessamashari/video-tool           |"
echo "|          Platform: GNU/Linux                                                  |"
echo "|          Version: 0.5                                                         |"
echo "+-------------------------------------------------------------------------------+"
echo -e "\n"

# ----------\Install dependencies\---------
checkDistro="0"
# Checking if the distro is DebianBase / ArchBase / RedHatBase / SuseBase and running the correct command

echo -e "${green} Enter your password for install dependencies\n${normal}"
if pacman -Q &> /dev/null; then # Check Arch
	sudo pacman -S ffmpeg git --needed
	# Check user's entered password
	if [[ !("$?" == "0") ]]; then
		checkDistro="1"
	fi
elif apt list --installed &> /dev/null; then # Check Debian
	sudo apt install ffmpeg git
	# Check user's entered password
	if [[ !("$?" == "0") ]]; then
		checkDistro="1"
	fi
elif dnf list &> /dev/null; then # Check Fedora
	sudo dnf install ffmpeg git
	# Check user's entered password
	if [[ !("$?" == "0") ]]; then
		checkDistro="1"
	fi
elif zypper search i+ &> /dev/null; then # Check openSUSE
	sudo zypper install ffmpeg git
	# Check user's entered password
	if [[ !("$?" == "0") ]]; then
		checkDistro="1"
	fi
else
	echo -e "${red}Your distro is neither ArchBase or DebianBase or RedHatBase or SuseBase So,
	 The script is not going to work in your distro and you have install it manually. for more information read README.md${normal}"
	checkDistro="1"
fi

# ----------\Adding video-tool Command and files\----------
if [ "$checkDistro" == "0" ]; then
	# Add command and changes path's
	sed "s/source src/source \/usr\/share\/video-tool\/src/g" video-tool | sudo tee /usr/bin/video-tool 1>/dev/null 2>&1
	sudo chmod 755 /usr/bin/video-tool

	# Add project files and resourses 
	sudo mkdir /usr/share/video-tool
	sudo cp -r src/ /usr/share/video-tool/
	sudo chmod -R 755 /usr/share/video-tool/

	# Change path's in project files
	for i in $(find /usr/share/video-tool -type f); do 
		sudo sed -i "s/source src/source \/usr\/share\/video-tool\/src/g" $i 
	done

	# Check the correctness of the operation
	if [[ "$?" == "0" ]]; then
		echo -e "\n ${green}video-tool succesfully installed ${normal}"
		echo -e "\n Use: ${orange}video-tool --help${normal} for other information"
	else
		echo -e "\n ${red}video-tool doesn't install succesfully ${normal}"
		exit 1
	fi
else
	echo -e "\n ${red}video-tool doesn't install succesfully ${normal}"
	exit 1
fi
