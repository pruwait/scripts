#!/bin/bash
if [ $EUID != 0 ]
then
	echo "------------------------------------------------------------------------------------"
	echo "                                  Run as a root                                     "
	echo "------------------------------------------------------------------------------------"
	exit 1
fi
cat <<-EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian/ bullseye main non-free
#deb-src http://deb.debian.org/debian/ bullseye main

deb http://security.debian.org/debian-security bullseye-security main contrib non-free
#deb-src http://security.debian.org/debian-security bullseye-security main contrib

deb http://deb.debian.org/debian/ bullseye-updates main contrib non-free
#deb-src http://deb.debian.org/debian/ bullseye-updates main contrib

deb http://deb.debian.org/debian bullseye-backports main contrib non-free
#deb-src http://deb.debian.org/debian bullseye-backports main contrib non-free


#для нестабильных обновлений с драйверами
#deb http://deb.debian.org/debian/ sid main non-free contrib
#deb-src http://deb.debian.org/debian/ sid main non-free contrib
EOF

apt update -y
apt upgrade -y
apt install -y  \
   software-properties-common  \
   apparmor-utils  \
   avahi-daemon  \
   dbus \
   jq \
   network-manager \
   socat  \
   apt-transport-https \
   ca-certificates \
   curl \
   gnupg \
   lsb-release \
   openssh-server \
   mc \
   udisks2 \
   libglib2.0-bin 

systemctl restart sshd
