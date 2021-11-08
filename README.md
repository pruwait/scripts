# scripts

Здесь храню полезные скрипты для упрощения частых операций.

debian-hassio-install-all-in1.sh
Завершает автоматизирует настройку после установки Debian 10 standart 

Для лучшего контроля можно запускать части скрипта по порядку.

Debian.
Актуальный образ здесь: https://cdimage.debian.org/debian-cd/current-live/amd64/bt-hybrid/
https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/

В лучшем случае ставим  debian-live-*-amd64-standard.iso
Если после перезагрузки не стартует, значит пробуем установку из gui через
debian-live-*-amd64-cinnamon.iso в дальнейшем удаляем все графические программы.

Пишем через rufus в режиме GPT FAT32

В корне флешки создаём папку Scripts, куда кидаем скрипты из https://github.com/pruwait/scripts

Перезагружаемся с жесткого диска
Подключите флешку и выполните
$fdisk -l
видим sdb1

$sudo mkdir /mnt/usb
$sudo mount /dev/sdb1 /mnt/usb

запускаем скрипты по порядку

$su
#bash /mnt/usb/scripts/1*

после скрипта 3-install-soft.sh можно подключаться по ssh и продолжить там.



