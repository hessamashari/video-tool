#!/bin/bash

    # This is the part of Video_Tool project on https://github.com/hessamashari/video-tool

normal="$(printf '\033[0m')"          # text mode
# Colors
red="$(printf '\033[0;31m')"  		  # red
green="$(printf '\033[0;32m')"        # green
orange="$(printf '\033[0;33m')"       # orange
blue="$(printf '\033[0;34m')"         # blue
white="$(printf '\033[0;37m')"        # white

# Import functions
source src/convert.sh 
source src/reduce.sh

# ----------\Refer to related function on src\----------
function refer_related_func() {
	local pathToVideo="$1"

	if [[ "$selectedItem" == "1" ]]; then
		reduce_video_size "$pathToVideo"
	elif [[ "$selectedItem" == "2" ]]; then
		convert_video_format "$pathToVideo"
	fi
}