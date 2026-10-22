@echo on
rem **************************************************
rem wol-diana
rem Wake-On-Line Server-Home Computer via Raspberrypi4
rem **************************************************
@echo off
klink.exe -P 22 -pw 0a9s8d7F vagrant@raspberrypi4 /home/vagrant/bin/wol-diana.sh
