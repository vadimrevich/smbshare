@echo on
rem **************************************************
rem wol-server
rem Wake-On-Line Server-Home Computer via Raspberrypi4
rem **************************************************
@echo off
klink.exe -P 22 -pw 0a9s8d7F pi@raspberrypi4 /home/pi/bin/wol-server.sh
