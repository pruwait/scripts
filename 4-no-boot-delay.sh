#!/bin/bash
if [ $EUID != 0 ]
then
	echo "------------------------------------------------------------------------------------"
	echo "                                  Run as a root                                     "
	echo "------------------------------------------------------------------------------------"
	exit 1
fi

# Убираем задержку при загрузке
sudo sed 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' -i /etc/default/grub
sudo update-grub
