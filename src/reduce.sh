#!/bin/bash

    # This is the part of Video_Tool project on https://github.com/hessamashari/video-tool

normal="$(printf '\033[0m')"          # text mode
# Colors
red="$(printf '\033[0;31m')"  		  # red
green="$(printf '\033[0;32m')"        # green
orange="$(printf '\033[0;33m')"       # orange
blue="$(printf '\033[0;34m')"         # blue
white="$(printf '\033[0;37m')"        # white

# ----------\Reduce the size of video function\----------
function reduce_video_size() {
	clear

	local inputVideo="$1"

	# Check access to video
	if [[ -r "$inputVideo" ]]; then
		read -p "Do you want to rename the new video? [Y/n] " renameNewVideo

		if [[ "$renameNewVideo" == "" || "$renameNewVideo" == "Y" || "$renameNewVideo" == "y" ]]; then
			read -p "Please write the new name : " newVideoName

			ffmpeg -i "$inputVideo" -vcodec h264 -acodec aac -strict -2 "$newVideoName.mp4"

			if [[ "$?" == "0" ]]; then
				echo -e "\n"
				echo -e "${green}Your video is ready : ${orange}$newVideoName${normal}"
			else
				echo -e "\n"
				echo -e "${red}Proccess doesn't finish succesfully!${normal}"
				exit 1
			fi
		elif [[ "$renameNewVideo" == "n" || "$renameNewVideo" == "N" ]]; then

			ffmpeg -i "$inputVideo" -vcodec h264 -acodec aac -strict -2 "$(echo "$inputVideo" | tr '.' ' ').mp4"

			# Check the correctness of the operation
			if [[ "$?" == "0" ]]; then
				echo -e "\n"
				echo -e "${green}Your video is ready : ${orange}$(echo "$inputVideo" | tr '.' ' ').mp4${normal}"
			else
				echo -e "\n"
				echo -e "${red}Proccess doesn't finish succesfully!${normal}"
				exit 1
			fi
		else
			echo -e "${red}Invalid argument!${normal}"
			exit 1
		fi
	else
		echo -e "\n"
		echo -e "${red}You haven't access to ${orange}'$inputVideo'${normal}"
		exit 1
	fi
}
