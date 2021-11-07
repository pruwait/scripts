#!/bin/bash
                                     
if [ $EUID != 0 ]
then
	echo "------------------------------------------------------------------------------------"
	echo "                                  Run as a root                                     "
	echo "------------------------------------------------------------------------------------"
	exit 1
fi

echo -e "Hassio Install \n"
wget https://github.com/home-assistant/supervised-installer/releases/latest/download/homeassistant-supervised.deb
dpkg -i homeassistant-supervised.deb
