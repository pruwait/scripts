rem Уточняем кодировку консоли
rem chcp
@echo Положить патченный и оригинальный загрузчик текущей прошивки в папку ./boot.
@echo Проверить отключение патчей в Magisk, обратить внимание на версию Magisk
@echo Если применялось скрытие приложения Magisk, сделать Восстановление приложения Magisk из Настройки>Приложение
@echo Удаляем патч Smali для текущего ядра, иначе бутлуп.
@echo  off
FOR /F "delims=" %%i IN ('where /r .\boot\ *magisk*.img') DO set magisk=%%i
FOR /F "delims=" %%i IN ('where /r .\boot\ *boot*.img') DO set stock=%%i

@echo Найден патченный бут magisk %magisk%
@echo Найден стоковый бут %stock%
@echo Рекомендуется пропатчить стоковый загрузчик текущей установленной на телефоне версией magisk, а не загружаться с сохраненного ранее magisk_patched.img


@pause
@echo Перезагружаем в фастбут...
adb reboot bootloader
@pause
TIMEOUT /T 20
@echo Проверяем правильную работу непатченного загрузчика. Если проблемы с загрузкой, останавливаем выполнение скрипта и ищем другое ядро.
fastboot boot %stock%

TIMEOUT /T 25
@echo Телефон загрузился. Можно шить ядро.
@echo Перезагружаем в фастбут и шьем немодифицированный загрузчик.
@pause
adb reboot bootloader

rem Прошиваем текущий непатченный boot.img в оба слота в режиме фастбут.
fastboot flash boot_a %stock%
fastboot flash boot_b %stock%

rem Загружаемся с текущего патченного boot.img чтобы иметь рут, но без модифицированных бут разделов.
fastboot boot %magisk%
fastboot reboot

@echo После загрузки заходим в Magisk и убеждаемся, что он установлен. Иначе не сможем патчить бут после обновления.
@echo На этом этапе возможна ситуация, когда приложение имеет более новую версию, чем установленный Magisk.
@echo Тогда приложение захочет перезагрузить телефон, нужно ему отказать. 
@echo .
@echo Устанавливаете инкрементальное обновление стандартным путем, по завершению не перезагружаете устройство.
@echo Через Magisk Manager прошиваете magisk в неактивный слот (Установка во второй слот (OTA).
@echo Перезагружаете устройство. Не отсоединяйте кабель USB, скрипт не завершён!
@pause
@echo После обновления OTA копируем из \data\magisk_backup_<SHA-1>\boot.img.gz на PC для последующих OTA
 
 


rem Создаём переменную с текущей версией rom
FOR /F "delims=" %%i IN ('adb shell getprop ro.rom.version') DO set rom=%%i
 
 rem Создаём папку для хранения текущих данных
 rem l mkdir -p /sdcard/magisk/%rom%

rem Вырезаем пробелы 
set rom=%rom: =%


adb shell mkdir -p /sdcard/magisk/%rom%
 rem set "dot=_"
 rem set "name=%rom%%dot%"
 
 rem Копируем оригинальный бут на sdcard
adb shell "su -c 'cp /data/magisk_backup*/*  /sdcard/magisk/%rom%/'"
 rem Получаем файл с sdcard и сохраняем с именем текущего rom
adb pull /sdcard/magisk/%rom%/boot.img.gz  ./boot/%rom%_boot.img.gz
 


@echo Запускаем на PC Smali Patcher. Генерируем патч под новый загрузчик.
@echo Копируем патч в папку телефона. Добавляем патч в Magisk.
@pause