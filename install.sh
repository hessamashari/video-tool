#!/bin/bash

# Video_Tool installer

	# author : Hessam Ashari
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
echo "+-------------------------------------------------------------------------------------+"
echo "|          Video usefull tools powered by ffmpeg and find command                     |"
echo "|          Author: Hessam Ashari                                                      |"
echo "|          Git repository: https://github.com/hessamashari/video-tool                 |"
echo "|          Platform: GNU/Linux                                                        |"
echo "|          Version: 0.4                                                               |"
echo "+-------------------------------------------------------------------------------------+"
echo -e "\n"

# ----------\Install dependencies\---------
checkDistro="0"
# Checking if the distro is DebianBase / ArchBase / RedHatBase / SuseBase and running the correct command

echo -e "${green} Enter your password for install dependencies\n${normal}"
if pacman -Q &> /dev/null; then # Check Arch
	sudo pacman -S ffmpeg git --needed
	# Check user's entered password
	if [[ "$?" == "1" ]]; then
		checkDistro="1"
	fi
elif apt list --installed &> /dev/null; then # Check Debian
	sudo apt install ffmpeg git
	# Check user's entered password
	if [[ "$?" == "1" ]]; then
		checkDistro="1"
	fi
elif dnf list &> /dev/null; then # Check Fedora
	sudo dnf install ffmpeg git
	# Check user's entered password
	if [[ "$?" == "1" ]]; then
		checkDistro="1"
	fi
elif zypper search i+ &> /dev/null; then # Check openSUSE
	sudo zypper install ffmpeg git
	# Check user's entered password
	if [[ "$?" == "1" ]]; then
		checkDistro="1"
	fi
else
	echo -e "${red}Your distro is neither ArchBase or DebianBase or RedHatBase or SuseBase So,
	 The script is not going to work in your distro and you have install it manually. for more information read README.md${normal}"
	checkDistro="1"
fi

# ----------\Adding video-tool Command\----------
if [ "$checkDistro" == "0" ]; then
    sudo cp video-tool /usr/bin/video-tool
    sudo chmod 755 /usr/bin/video-tool
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
