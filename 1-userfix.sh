#!/bin/bash
if [ $EUID != 0 ]
then
	echo "------------------------------------------------------------------------------------"
	echo "                                  Run as a root                                     "
	echo "------------------------------------------------------------------------------------"
	exit 1
fi

/usr/sbin/usermod -aG sudo j
# SUDO без пароля

echo "j ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/j
