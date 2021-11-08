#!/bin/bash

if [ $EUID != 0 ]
then
	echo "------------------------------------------------------------------------------------"
	echo "                                  Run as a root                                     "
	echo "------------------------------------------------------------------------------------"
	exit 1
fi

mkdir /home/j/.ssh

#Если папка была создана ранее и принадлежит root, меняем хозяина
sudo chown -R j:j /home/j/.ssh

#создаём в докере папку ключей
sudo docker exec -it homeassistant /bin/mkdir /config/sshkey -p
sudo docker exec -it homeassistant /usr/bin/ssh-keygen -q -N '' -t rsa -f /config/sshkey/id_rsa
