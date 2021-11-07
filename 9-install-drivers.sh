#!/bin/bash
                                     
if [ $EUID != 0 ]
then
	echo "------------------------------------------------------------------------------------"
	echo "                                  Run as a root                                     "
	echo "------------------------------------------------------------------------------------"
	exit 1
fi

echo -e "Add repositary...\n"

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
deb http://deb.debian.org/debian/ sid main non-free contrib
#deb-src http://deb.debian.org/debian/ sid main non-free contrib
EOF


apt update -y

apt install -y apt-file firmware-misc-nonfree firmware-iwlwifi firmware-linux
apt-file update -y

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

