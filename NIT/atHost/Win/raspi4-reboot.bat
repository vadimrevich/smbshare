@echo on
rem **********************************************
rem raspi4-reboot.bat
rem This Script will Reboot raspberrypy4 Server Remotely
rem **********************************************
@echo off
klink.exe -P 22 -pw 0a9s8d7F pi@raspberrypi4 "sudo reboot"
