@echo on
rem *******************************************************
rem set.keenetic-giga.ip.static.cmd
rem This Script will Set a Port Forwarding at
rem Keenetic-Giga Router
rem ******************************************************
echo off

rem Set a MAC Address Variables
rem
set RASPI4MAC=e4:5f:01:a7:28:fc
set RASPI3MAC=b8:27:eb:54:e8:fd
set ZYXELOLDMAC=40:4a:03:79:8b:cc 
set LAPTOPMAC=a8:5e:45:d5:44:b3
set WINSERVERMAC=78:ac:c0:88:55:fd
set DIANALAPMAC=38:60:77:94:67:a5
set LENOVOTABMAC=94:be:46:70:45:dd
set REDME9MUMMAC=4c:f2:02:4b:09:ab
set ANDROIDTVMAC=fc:a4:7a:a1:07:66
set REDME12CMAC=56:da:a0:4a:ef:73
set REDMENOTEMAC=50:da:d6:5c:29:54
set REDME12YDMAC=4a:61:f1:8b:e5:4f
set KEENETICMAC=50:ff:20:0d:c9:78

rem Set an IPv4 Addresses
rem
set RASPI3IP=192.168.252.4
set RASPI4IP=192.168.252.5
set ZYXELOLDIP=192.168.252.254
set LAPTOPIP=192.168.252.3
set WINSERVERIP=192.168.252.2
set DIANALAPIP=192.168.252.6
set LENOVOTABIP=192.168.252.38
set REDME9MUMIP=192.168.252.85
set ANDROIDTVIP=192.168.252.68
set REDME12CIP=192.168.252.84
set REDMENOTEIP=192.168.252.74
set REDME12YDIP=192.168.252.7
set KEENETICIP=192.168.252.1

rem Set Keenetic Connections
rem

set KEENSSHPORT=55022
set KEENIP=192.168.252.1
set KEENUSER=admin
set KEENPASS=0a9s8d7F

rem Set Connection Command

set KEENCMD="klink.exe -P %KEENSSHPORT% -pw %KEENPASS% %KEENUSER%@%KEENIP% "
set KEENCMD=%KEENCMD:"=%

rem Run Payloads
%KEENCMD% ip static tcp PPPoE0 22080 %RASPI4MAC% !apache2 raspi4
%KEENCMD% ip static tcp PPPoE0 22022 %RASPI4MAC% 22 !SSH raspi4
%KEENCMD% ip static tcp PPPoE0 111 %RASPI4MAC% !rpcbind raspi4
%KEENCMD% ip static tcp PPPoE0 2049 %RASPI4MAC% !nfs raspi4
%KEENCMD% ip static tcp PPPoE0 10022 %LAPTOPMAC% 22 !SSH Laptop
%KEENCMD% ip static tcp PPPoE0 6000 %LAPTOPMAC% !XServer Laptop
%KEENCMD% ip static tcp PPPoE0 12080 %LAPTOPMAC% 80 !HTTP IIS Laptop
%KEENCMD% ip static tcp PPPoE0 4782 %LAPTOPMAC% !Quasar Laptop
%KEENCMD% ip static tcp PPPoE0 10022 %LAPTOPMAC% !SSH Laptop
%KEENCMD% ip static tcp PPPoE0 1446 %LAPTOPMAC% 445 !SMB Laptop
%KEENCMD% ip static tcp PPPoE0 1445 %WINSERVERMAC% 445 !SMB WinServer
%KEENCMD% ip static tcp PPPoE0 1450 %DIANALAPMAC% 445 !SMB Diana_Laptop
%KEENCMD% ip static tcp PPPoE0 10002 %RASPI4MAC% 10000 !webmin raspi4
%KEENCMD% ip static tcp PPPoE0 9000 %RASPI4MAC% !Portainer raspi4
%KEENCMD% ip static tcp PPPoE0 8282 %RASPI4MAC% !Guacamole raspi4

%KEENCMD% system configuration save

%KEENCMD% show running-config | grep "static"

echo The End of the Script %0
exit /b 0


