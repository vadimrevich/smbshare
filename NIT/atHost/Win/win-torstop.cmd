@echo off
rem Stop TOR Service on WIN Server

rem ssh start
klink.exe -P 22 -pw 0a9s8d7F vagrant@win "net stop tor"

rem winrm start
winrs -r:win -u:WIN\vagrant -p:0a9s8d7F "net stop tor"

