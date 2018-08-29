#!/bin/bash

    # This is the part of Video_Tool project on https://github.com/hessamashari/video-tool

normal="$(printf '\033[0m')"          # text mode
# Colors
red="$(printf '\033[0;31m')"  		  # red
green="$(printf '\033[0;32m')"        # green
orange="$(printf '\033[0;33m')"       # orange
blue="$(printf '\033[0;34m')"         # blue
white="$(printf '\033[0;37m')"        # white

# ----------\Update function\----------
function update() {
	clear

	# Check place of repo for existing files
	if [[ -d /tmp/video-tool/ ]]; then
		sudo rm -rf /tmp/video-tool/
	fi

	# Check access of /tmp
	if cd /tmp/ &> /dev/null; then
		git clone https://github.com/hessamashari/video-tool.git /tmp/video-tool
		sleep 2

		echo -e "\n"
		# Check access of /tmp/video-tool
		if cd /tmp/video-tool/ &> /dev/null; then
			# Replace older program with newer
            sed "s/source src/source \/usr\/share\/video-tool\/src/g" video-tool | sudo tee /usr/bin/video-tool 1>/dev/null 2>&1
	        sudo chmod 755 /usr/bin/video-tool

            # Replace older project files with newer
            sudo cp -r /tmp/video-tool/src /usr/share/video-tool/
            sudo chmod -R 755 /usr/share/video-tool

            # Change path's in project files
            for i in $(find /usr/share/video-tool -type f); do 
                sudo sed -i "s/source src/source \/usr\/share\/video-tool\/src/g" $i 
            done

			echo -e "\n"
			# Check the correctness of the operation
			if [[ "$?" == "0" ]]; then
				echo -e " ${green}Video_Tool updated succesfully! ${normal}"
			else
				echo -e " ${red}Video_Tool doesn't update succesfully! ${normal}"
				exit 1
			fi
		else
			echo -e "\n"
			echo -e "${red}Cannot cd to directory ${orange}'/tmp/video-tool'${normal}"
			exit 1
		fi
	else
		echo -e "\n"
		echo -e "${red}Cannot cd to directory ${orange}'/tmp'${normal}"
		exit 1
	fi

	# Delet cloned repository
	sudo rm -rf /tmp/video-tool
}
