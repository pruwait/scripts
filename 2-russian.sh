#!/bin/bash
if [ $EUID != 0 ]
then
	echo "------------------------------------------------------------------------------------"
	echo "                                  Run as a root                                     "
	echo "------------------------------------------------------------------------------------"
	exit 1
fi

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
