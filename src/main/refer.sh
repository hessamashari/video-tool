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
source src/convert.sh 
source src/reduce.sh

# ----------\Refer to related function on src\----------
refer_related_func() {
	local pathToVideo="$1"

	if [[ "$selectedItem" == "1" ]]; then
		reduce_video_size "$pathToVideo"
	elif [[ "$selectedItem" == "2" ]]; then
		convert_video_format "$pathToVideo"
	fi
}