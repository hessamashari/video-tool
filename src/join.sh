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

# ---------- function for join multiple video files ----------
join_videos() {
    clear

    echo -e "${orange}You need to tell me the path of videos${normal}"

    # Remove /tmp/videos.list file if it exist
    [[ -f /tmp/videos.list || -w /tmp/videos.list ]] && rm -rf /tmp/videos.list 1> /dev/null 2>&1

    # Add path's to list file
    while [[ "1" == "1" ]]; do
        read -p "   Enter path of video [${red} It must be absolute path ${normal}] : " -i "" -e pathOfVideo

        # Check access to video
        if [[ -r "$pathOfVideo" ]]; then
            if cd /tmp/ &> /dev/null; then
                echo "file '$pathOfVideo'" >> /tmp/videos.list    # Add each path to list
            else
	            echo -e "\n"
            	echo -e "${red}Cannot cd to directory ${orange}'/tmp'${normal}"
        	    exit 1
            fi

            # Question for add other path's
            read -p "${green} Do you want to add another video to then list?? [Y/n] ${normal}" addAnotherVideo
            echo -e "\n"

            if [[ "$addAnotherVideo" == "" || "$addAnotherVideo" == "y" || "$addAnotherVideo" == "" ]]; then
                continue;    # Ask new path
            elif [[ "$addAnotherVideo" == "n" || "$addAnotherVideo" == "N" ]]; then
                clear

                read -p "${green}Enter the name of new video : ${normal}" nameOfNewVideo
                read -p "${green}Enter path of new video : ${normal}" -i "" -e pathOfNewVideo

                # Main job
                ffmpeg -f concat -safe 0 -i /tmp/videos.list -c copy "$pathOfNewVideo"$nameOfNewVideo.mp4

                # Check the correctness of the operation
                if [[ "$?" == "0" ]]; then
                    echo -e "\n"
                    echo -e "${green}Your video is ready : ${orange}$pathOfNewVideo$nameOfNewVideo.mp4${normal}"
                    return
                else
                    echo -e "\n"
                    echo -e "${red}Proccess doesn't finish succesfully!${normal}"
                    exit 1
                fi
            else
                echo -e "${red}Invalid argument! ${normal}"
                exit 1
            fi
        else
            echo -e "\n"
            echo -e "${red}Video doesn't exist!!!${normal}"
            exit 1
        fi
    done
}
