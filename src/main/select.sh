#!/bin/bash

	# This file is part of Video_Tool.
	#
	# Video_Tool is free software: you can redistribute it and/or modify
	# it under the terms of the GNU General Public License as published by
	# the Free Software Foundation, either version 3 of the License, or
	# (at your option) any later version.
	#
	# Video_Tool is distributed in the hope that it will be useful,
	# but WITHOUT ANY WARRANTY; without even the implied warranty of
	# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	# GNU General Public License for more details.

normal="$(printf '\033[0m')"          # text mode
# Colors
red="$(printf '\033[0;31m')"  		  # red
green="$(printf '\033[0;32m')"        # green
orange="$(printf '\033[0;33m')"       # orange
blue="$(printf '\033[0;34m')"         # blue
white="$(printf '\033[0;37m')"        # white

# Import functions
source src/main/find.sh 
source src/main/refer.sh 

# ---------- Select movie function ----------
select_video_path() {
	# Ask for video path
	read -p "${green}Do you want to search video for you ${orange}{search / s}${green} or you know the video location ${orange}{location / l}${normal} : " searchVideoAnswer
	clear

	echo -e "ُ${red}+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+${normal}"

	if [[ "$searchVideoAnswer" == "search" || "$searchVideoAnswer" == "S" || "$searchVideoAnswer" == "s" ]]; then
		read -p "Do you like to serach all of your system (Requires root access)? [Y/n] " searchAllSystem

		if [[ "$searchAllSystem" == "" || "$searchAllSystem" == "y" || "$searchAllSystem" == "Y" ]]; then
			# Search all of file system
		    echo -e "This operation may take a while!"

			find_video "/"
		elif [[ "$searchAllSystem" == "n" || "$searchAllSystem" == "N" ]]; then
			read -p "Do you like search this directory? [Y/n] " workingDirectory

			if [[ "$workingDirectory" == "" || "$workingDirectory" == "y" || "$workingDirectory" == "Y" ]]; then
				# Search current directory

				find_video "$PWD"
			elif [[ "$workingDirectory" == "n" || "$workingDirectory" == "N" ]]; then
				# Search entered path
				read -p "Enter a directory : " -i "" -e userEnteredPath
					if [[ "$userEnteredPath" == "/" ]]; then
						echo -e "${red}You have to chose first option :)${normal}"
					else
						[[ -d "$userEnteredPath" ]] && find_video "$userEnteredPath"
					fi
			else
				echo -e "${red}Invalid argument!${normal}"
				exit 1
			fi
		else
		    echo -e "${red}Invalid argument!${normal}"
			exit 1
		fi
	elif [[ "$searchVideoAnswer" == "location" || "$searchVideoAnswer" == "L" || "$searchVideoAnswer" == "l" ]]; then
		# Read path/to/video
		read -p "Enter path of the video : " -i "" -e videoPath

		refer_related_func "$videoPath"
	else
		echo -e "${red}Invalid argument!${normal}"
		exit 1
	fi
}
