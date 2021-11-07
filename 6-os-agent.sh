#!/bin/bash

if [ $EUID != 0 ]
then
	echo "------------------------------------------------------------------------------------"
	echo "                                  Run as a root                                     "
	echo "------------------------------------------------------------------------------------"
	exit 1
fi

echo -e "OS Agent Install \n"
cd ~

curl -s https://api.github.com/repos/home-assistant/os-agent/releases/latest \
| grep "browser_download_url.*linux_x86_64.deb" \
| cut -d '"' -f 4 \
| wget -qi -

sudo dpkg -i os-agent*linux_x86_64.deb
