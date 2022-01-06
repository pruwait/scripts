rem ���塞 ����஢�� ���᮫�
rem chcp
@echo �������� ���祭�� � �ਣ������ �����稪 ⥪�饩 ��訢�� � ����� ./boot.
@echo �஢���� �⪫�祭�� ���祩 � Magisk, ������ �������� �� ����� Magisk
@echo �᫨ �ਬ��﫮�� ���⨥ �ਫ������ Magisk, ᤥ���� ����⠭������� �ਫ������ Magisk �� ����ன��>�ਫ������
@echo ����塞 ���� Smali ��� ⥪�饣� ��, ���� ����.
@echo  off
FOR /F "delims=" %%i IN ('where /r .\boot\ *magisk*.img') DO set magisk=%%i
FOR /F "delims=" %%i IN ('where /r .\boot\ *boot*.img') DO set stock=%%i

@echo ������ ���祭�� ��� magisk %magisk%
@echo ������ �⮪��� ��� %stock%
@echo ������������ �ய����� �⮪��� �����稪 ⥪�饩 ��⠭�������� �� ⥫�䮭� ���ᨥ� magisk, � �� ����㦠���� � ��࠭������ ࠭�� magisk_patched.img


@pause
@echo ��१���㦠�� � �����...
adb reboot bootloader
@pause
TIMEOUT /T 20
@echo �஢��塞 �ࠢ����� ࠡ��� �����祭���� �����稪�. �᫨ �஡���� � ����㧪��, ��⠭�������� �믮������ �ਯ� � �饬 ��㣮� ��.
fastboot boot %stock%

TIMEOUT /T 25
@echo ����䮭 ����㧨���. ����� ��� ��.
@echo ��१���㦠�� � ����� � �쥬 ��������஢���� �����稪.
@pause
adb reboot bootloader

rem ��訢��� ⥪�騩 �����祭�� boot.img � ��� ᫮� � ०��� �����.
fastboot flash boot_a %stock%
fastboot flash boot_b %stock%

rem ����㦠���� � ⥪�饣� ���祭���� boot.img �⮡� ����� ���, �� ��� ������஢����� ��� ࠧ�����.
fastboot boot %magisk%
fastboot reboot

@echo ��᫥ ����㧪� ��室�� � Magisk � 㡥�������, �� �� ��⠭�����. ���� �� ᬮ��� ������ ��� ��᫥ ����������.
@echo �� �⮬ �⠯� �������� �����, ����� �ਫ������ ����� ����� ����� �����, 祬 ��⠭������� Magisk.
@echo ����� �ਫ������ ����� ��१���㧨�� ⥫�䮭, �㦭� ��� �⪠����. 
@echo .
@echo ��⠭�������� ���६��⠫쭮� ���������� �⠭����� ��⥬, �� �����襭�� �� ��१���㦠�� ���ன�⢮.
@echo ��१ Magisk Manager ��訢��� magisk � ����⨢�� ᫮� (��⠭���� �� ��ன ᫮� (OTA).
@echo ��१���㦠�� ���ன�⢮. �� ��ᮥ����� ������ USB, �ਯ� �� �������!
@pause
@echo ��᫥ ���������� OTA �����㥬 �� \data\magisk_backup_<SHA-1>\boot.img.gz �� PC ��� ��᫥����� OTA
 
 


rem ������ ��६����� � ⥪�饩 ���ᨥ� rom
FOR /F "delims=" %%i IN ('adb shell getprop ro.rom.version') DO set rom=%%i
 
 rem ������ ����� ��� �࠭���� ⥪��� ������
 rem l mkdir -p /sdcard/magisk/%rom%

rem ��१��� �஡��� 
set rom=%rom: =%


adb shell mkdir -p /sdcard/magisk/%rom%
 rem set "dot=_"
 rem set "name=%rom%%dot%"
 
 rem �����㥬 �ਣ������ ��� �� sdcard
adb shell "su -c 'cp /data/magisk_backup*/*  /sdcard/magisk/%rom%/'"
 rem ����砥� 䠩� � sdcard � ��࠭塞 � ������ ⥪�饣� rom
adb pull /sdcard/magisk/%rom%/boot.img.gz  ./boot/%rom%_boot.img.gz
 


@echo ����᪠�� �� PC Smali Patcher. ������㥬 ���� ��� ���� �����稪.
@echo �����㥬 ���� � ����� ⥫�䮭�. ������塞 ���� � Magisk.
@pause