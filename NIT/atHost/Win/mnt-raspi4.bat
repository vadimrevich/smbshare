@echo on
rem *******************************************************
rem mnt-raspi4.bat
rem This Script will mount raspberrypi4 nfs shares to net drive
rem This Script Must Run without Elevated Privileges
rem See https://interface31.ru/tech_it/2023/07/ustanavlivaem-i-nastraivaem-nfs-klient-v-windows.html
rem
rem *******************************************************
@echo off

rem Set a Variables
set aHost=192.168.252.5
set r_Path01=\home\vagrant

echo Run a Payload...
mount -o anon \\%aHost%%r_Path01% z:
