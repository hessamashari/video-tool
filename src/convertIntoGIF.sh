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

# ---------- Convert the video into a GIF function ----------
convert_video_into_gif() {
    clear

    local inputVideo="$1"

    # Check access to video
    if [[ -r "$inputVideo" ]]; then
        read -p "Enter the width of the GIF or press Enter for default(1000:-1) : " widthOfGif

        # Set default width for video
        if [[ "$widthOfGif" == "" ]]; then
            widthOfGif="1000:-1"
        fi

        read -p "Enter the duration of GIF in seconds : " durationOfGifSec

        read -p "Enter the frame rate (fps) or press Enter for default(300) :  " frameRate

        # Set default frameRate
        if [[ "$frameRate" == "" ]]; then
            frameRate="300"
        fi

        read -p "Do you want to rename the GIF? [Y/n] " renameGif

        if [[ "$renameGif" == "" || "$renameGif" == "Y" || "$renameGif" == "y" ]]; then
            read -p "Please write the name : " gifName

            ffmpeg -i "$inputVideo" -vf scale="$widthOfGif" -t "$durationOfGifSec" -r "$frameRate" "$GifName.gif"

            # Check the correctness of the operation
            if [[ "$?" == "0" ]]; then
                echo -e "\n"
                echo -e "${green}Your GIF is ready : ${orange}$gifName.gif${normal}"
            else
                echo -e "\n"
                echo -e "${red}Proccess doesn't finish succesfully!${normal}"
                exit 1
            fi
        elif [[ "$renameGif" == "n" || "$renameGif" == "N" ]]; then

            ffmpeg -i "$inputVideo" -vf scale="$widthOfGif" -t "$durationOfGifSec" -r "$frameRate" "$(echo "$inputVideo" | tr '.' ' ').gif"

            # Check the correctness of the operation
            if [[ "$?" == "0" ]]; then
                echo -e "\n"
                echo -e "${green}Your GIF is ready : ${orange}$(echo "$inputVideo" | tr '.' ' ').gif${normal}"
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
