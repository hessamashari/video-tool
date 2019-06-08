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

# ---------- Reduce the size of video function ----------
extract_audio_from_video() {
    clear

    local inputVideo="$1"

    # Check access to video
    if [[ -r "$inputVideo" ]]; then
        read -p "Do you want to rename the audio? [Y/n] " renameAudio

        if [[ "$renameAudio" == "" || "$renameAudio" == "Y" || "$renameAudio" == "y" ]]; then
            read -p "Please write the name : " audioName

			ffmpeg -i "$inputVideo" -vn -y "$audioName.mp3"

            # Check the correctness of the operation
            if [[ "$?" == "0" ]]; then
                echo -e "\n"
                echo -e "${green}Your audio is ready : ${orange}$audioName.mp3${normal}"
            else
                echo -e "\n"
                echo -e "${red}Proccess doesn't finish succesfully!${normal}"
                exit 1
            fi
        elif [[ "$renameAudio" == "n" || "$renameAudio" == "N" ]]; then

			ffmpeg -i "$inputVideo" -vn -y "$(echo "$inputVideo" | tr '.' ' ').mp3"

            # Check the correctness of the operation
            if [[ "$?" == "0" ]]; then
                echo -e "\n"
                echo -e "${green}Your audio is ready : ${orange}$(echo "$inputVideo" | tr '.' ' ').mp3${normal}"
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
