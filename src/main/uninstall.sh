#!/bin/bash

    # This is the part of Video_Tool project on https://github.com/hessamashari/video-tool

normal="$(printf '\033[0m')"          # text mode
# Colors
red="$(printf '\033[0;31m')"  		  # red
green="$(printf '\033[0;32m')"        # green
orange="$(printf '\033[0;33m')"       # orange
blue="$(printf '\033[0;34m')"         # blue
white="$(printf '\033[0;37m')"        # white

# ----------\Uninstall function\----------
function uninstall() {
	clear

	read -p "${red}Are you sure to uninstall video-tool??!! [y/N] ${normal}" deletVideoTool

	# Remove dependencies
	if [[ "$deletVideoTool" == "y" || "$deletVideoTool" == "Y" ]]; then
		deleteDependencies="0"
		# Checking if the distro is DebianBase / ArchBase / RedHatBase / SuseBase and running the correct command

		if pacman -Q &> /dev/null; then # Check Arch
			sudo pacman -Rs ffmpeg
			# Check user's entered password
			if [[ !("$?" == "0") ]]; then
				deleteDependencies="1"
			fi
		elif apt list --installed &> /dev/null; then # Check Debian
			sudo apt remove ffmpeg
			# Check user's entered password
			if [[ !("$?" == "0") ]]; then
				deleteDependencies="1"
			fi
		elif dnf list &> /dev/null; then # Check Fedora
			sudo dnf remove ffmpeg
			# Check user's entered password
			if [[ !("$?" == "0") ]]; then
				deleteDependencies="1"
			fi
		elif zypper search i+ &> /dev/null; then # Check openSUSE
			sudo zypper remove ffmpeg
			# Check user's entered password
			if [[ !("$?" == "0") ]]; then
				deleteDependencies="1"
			fi
		else
			echo -e "${red}Your distro is neither ArchBase or DebianBase or RedHatBase or SuseBase So,
			 The script is not going to work in your distro and you have uninstall the dependencies manually.${normal}"
			deleteDependencies="1"
		fi

		# Removing video-tool Command
		if [[ "$deleteDependencies" == "0" ]]; then
            # Remove command
			sudo rm -f /usr/bin/video-tool
			
            # Remove other files
            sudo rm -rf /usr/share/video-tool/

            # Check the correctness of the operation
            if [[ "$?" == "0" ]]; then
				echo -e "\n"
				echo -e "${red}video-tool succesfully uninstalled :( ${normal}"
			else
				echo -e "\n"
				echo -e "${green}video-tool doesn't uninstall succesfully :) ${normal}"
				exit 1
			fi
		else
			echo -e "\n"
			echo -e "${green}video-tool doesn't uninstall succesfully :) ${normal}"
			exit 1
		fi
	elif [[ "$deletVideoTool" == "" || "$deletVideoTool" == "n" || "$deletVideoTool" == "N" ]]; then
		echo -e "\n"
		echo -e "${green}video-tool is still installed :) ${normal}"
		return
	else
		echo -e "${red}Invalid argument! ${normal}"
		exit 1
	fi
}
