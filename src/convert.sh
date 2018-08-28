#!/bin/bash

    # This is the part of Video_Tool project on https://github.com/hessamashari/video-tool

normal="$(printf '\033[0m')"          # text mode
# Colors
red="$(printf '\033[0;31m')"  		  # red
green="$(printf '\033[0;32m')"        # green
orange="$(printf '\033[0;33m')"       # orange
blue="$(printf '\033[0;34m')"         # blue
white="$(printf '\033[0;37m')"        # white

# ----------\Change format on video function\----------
function convert_video_format() {
	clear

	local inputVideo="$1"
	local videoFormts=("mkv" "mp4" "mp3" "mov" "ogg" "wmv" "webm" "vob" "avi" "flv" "3gp" "ogv" "m4v" "mng" "fv4" "svi" "amv") # Use for using fewer if

	# Check access to video
	if [[ -r "$inputVideo" ]]; then
		echo -e "ُ${red}+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+${normal}"
		read -p "${green}What format do you want to convert ?${normal}
		1)${orange} mkv${normal}
		2)${orange} mp4${normal}
		3)${orange} mp3${normal}
		4)${orange} mov${normal}
		5)${orange} ogg${normal}
		6)${orange} wmv${normal}
		7)${orange} webm${normal}
		8)${orange} vob${normal}
		9)${orange} avi${normal}
		10)${orange} flv${normal}
		11)${orange} 3gp${normal}
		12)${orange} ogv${normal}
		13)${orange} m4v${normal}
		14)${orange} mng${normal}
		15)${orange} fv4${normal}
		16)${orange} svi${normal}
		17)${orange} amv${normal}

		Enter the number of the option that you selected : " newVideoFormat
		echo -e "ُ${red}+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+${normal}"

        # Check the given number is larger than options or not
		if [[ "$newVideoFormat" -gt "-1" && "$newVideoFormat" -lt $((${#videoFormts[@]}+1)) ]]; then
			echo -e "${green}This operation may take a while because I do not like to put down the quality of your video!${normal}"
			echo -e "\n"
			sleep 5

			# Change format
			ffmpeg -i "$inputVideo" -c:v libx264 "$(echo "$inputVideo" | tr '.' ' ')".${videoFormts[$(("$newVideoFormat"-1))]}

		else
			echo -e "${red}Your selected number doesn't match with my options!${normal}"
			exit 1
		fi

		# Check the correctness of the operation
		if [[ "$?" == "0" ]]; then
			echo -e "\n"
			echo -e "${green}Your video is ready : ${orange}"$(echo "$inputVideo" | tr '.' ' ')".${videoFormts[$(("$newVideoFormat"-1))]} ${normal}"
		else
			echo -e "\n"
			echo -e "${red}Proccess doesn't finish succesfully!${normal}"
			exit 1
		fi
	else
		echo -e "\n"
		echo -e "${red}You haven't access to ${orange}'$inputVideo'${normal}"
		exit 1
	fi
}
