#!/bin/bash

echo """
+---------------------------------------------------------------------------------+
|                            Debian 11 Home Assistant Install                                 |
+---------------------------------------------------------------------------------+
"""
                                     
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
EOF


apt update -y
apt upgrade -y


echo -e "[+] Add user to SUDO\n"
/usr/sbin/usermod -aG sudo j


apt install -y  \
   software-properties-common  \
   apparmor-utils  \
   avahi-daemon  \
   dbus jq network-manager socat  \
   apt-transport-https \
   ca-certificates \
   curl \
   gnupg \
   lsb-release \
   openssh-server mc


systemctl restart sshd

# Русская локаль
# Uncomment en_US.UTF-8 for inclusion in generation
sed -i 's/^# *\(ru_RU.UTF-8\)/\1/' /etc/locale.gen


locale-gen --purge ru_RU.UTF-8

echo -e 'LANG="LANG=ru_RU.UTF-8"\nLC_ALL=ru_RU.UTF-8\n' > /etc/default/locale

# Export env vars
echo "export LC_ALL=ru_RU.UTF-8" >> ~/.bashrc
echo "export LANG=ru_RU.UTF-8" >> ~/.bashrc
echo "export LANGUAGE=ru_RU.UTF-8" >> ~/.bashrc

# Русская консоль
cat <<-EOF > /etc/default/console-setup
ACTIVE_CONSOLES="/dev/tty[1-6]"

CHARMAP="UTF-8"

CODESET="CyrSlav"
FONTFACE="Terminus"
FONTSIZE="8x16"

VIDEOMODE=
EOF

# SUDO без пароля

echo "j ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/j


echo -e "Torrserver \n"
# Устанавливаем  Torrserver

sudo mkdir /opt/torrserver
cd /opt/torrserver
curl -s  https://api.github.com/repos/YouROK/TorrServer/releases/latest | jq -r '.assets[] | select(.name=="TorrServer-linux-amd64") | .browser_download_url' | wget -qi -
sudo chmod +x /opt/torrserver/TorrServer-linux-amd64
sudo touch /etc/systemd/system/torrserver.service
sudo chmod 664  /etc/systemd/system/torrserver.service
#sudo nano /etc/systemd/system/torrserver.service

cat <<-EOF > /etc/systemd/system/torrserver.service
[Unit]
Description=torrserver
After=network.target

[Install]
WantedBy=multi-user.target

[Service]
Type=simple
NonBlocking=true
WorkingDirectory=/opt/torrserver
ExecStart=/opt/torrserver/TorrServer-linux-amd64 --p 8090
Restart=on-failure
RestartSec=5s
EOF
sudo systemctl daemon-reload
sudo systemctl start torrserver
sudo systemctl enable torrserver
