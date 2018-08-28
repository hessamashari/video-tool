#!/bin/bash

source src/convert.sh 
source src/reduce.sh

# ----------\Refer to related function\----------
function refer_related_func() {
	local pathToVideo="$1"

	if [[ "$selectedItem" == "1" ]]; then
		reduce_video_size "$pathToVideo"
	elif [[ "$selectedItem" == "2" ]]; then
		convert_video_format "$pathToVideo"
	fi
}