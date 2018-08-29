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
source src/main/refer.sh 

# ---------- Find video function ----------
find_video() {
	clear

	local inputDir="$1"
	local IFS=":" # Use for sed

	read -p "Please enter the name of video : " videoName

	# Separating files that have video format
	local videoTypes="\.webm$|\.flv$|\.vob$|\.ogg$|\.ogv$|\.drc$|\.gifv$|\.mng$|\.avi$|\.mov$|\.qt$|\.wmv$|\.yuv$|\.rm$|\.rmvb$|/.asf$|\.amv$|\.mp4$|\.m4v$|\.mp*$|\.m?v$|\.svi$|\.3gp$|\.ts$|\.flv$|\.f4v$"

	echo -e "\n"
	if [[ "$inputDir" == "/" ]]; then
		sudo find / -type f -iname "*$videoName*" | grep -E "$videoTypes"
		local searchDir=$(sudo find / -type f -iname "*$videoName*" | grep -E "$videoTypes")
	else
		find "$inputDir" -type f -iname "*$videoName*" | grep -E "$videoTypes"
		local searchDir=$(find "$inputDir" -type f -iname "*$videoName*" | grep -E "$videoTypes")
	fi

		# Creat file with found videos and change \n to : on it
		echo $searchDir > /tmp/searchDir
		sed -i ':a;N;$!ba;s/\n/:/g' /tmp/searchDir

	# Ask for all videos were found
	for videoPath in $(cat /tmp/searchDir); do
		echo -e "\n"
		read -p "${green} Would you like to work with ${orange}'$videoPath'${normal}? [Y/n] "  workWithThis

		if [[ "$workWithThis" == "" || "$workWithThis" == "y" || "$workWithThis" == "Y" ]]; then
			refer_related_func "$videoPath"
		elif [[ "$workWithThis" == "n" || "$workWithThis" == "N" ]]; then
			continue
		else
			echo -e "${red}Invalid argument!${normal}"
			continue
		fi
	done

	# Remove searchDir file
	rm -rf /tmp/searchDir
}
