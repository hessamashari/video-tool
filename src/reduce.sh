#!/bin/bash

# ----------\Reduce video size function\----------
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

			# Check operation
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