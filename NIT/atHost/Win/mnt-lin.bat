@echo on
rem *******************************************************
rem mnt-lin.bat
rem This Script will mount lin nfs shares to net drive
rem This Script Must Run without Elevated Privileges
rem See https://interface31.ru/tech_it/2023/07/ustanavlivaem-i-nastraivaem-nfs-klient-v-windows.html
rem
rem *******************************************************
@echo off

rem Set a Variables
set aHost=lin.netip4.ru
set r_Path01=\home\vagrant

echo Run a Payload...
mount -o anon \\%aHost%%r_Path01% z:
