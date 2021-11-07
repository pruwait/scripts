#!/bin/bash
                                     
if [ $EUID != 0 ]
then
	echo "------------------------------------------------------------------------------------"
	echo "                                  Run as a root                                     "
	echo "------------------------------------------------------------------------------------"
	exit 1
fi

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
