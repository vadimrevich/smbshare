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
%KEENCMD% ip dhcp host %RASPI4MAC% %RASPI4IP%
%KEENCMD% ip dhcp host %RASPI3MAC% %RASPI3IP%
%KEENCMD% ip dhcp host %ZYXELOLDMAC% %ZYXELOLDIP%
%KEENCMD% ip dhcp host %LAPTOPMAC% %LAPTOPIP%
%KEENCMD% ip dhcp host %WINSERVERMAC% %WINSERVERIP%
%KEENCMD% ip dhcp host %DIANALAPMAC% %DIANALAPIP%
%KEENCMD% ip dhcp host %LENOVOTABMAC% %LENOVOTABIP%
%KEENCMD% ip dhcp host %REDME9MUMMAC% %REDME9MUMIP%
%KEENCMD% ip dhcp host %REDME12CMAC% %REDME12CIP%
%KEENCMD% ip dhcp host %REDME12YDMAC% %REDME12YDIP%
%KEENCMD% ip dhcp host %ANDROIDTVMAC% %ANDROIDTVIP%
%KEENCMD% ip dhcp host %REDMENOTEMAC% %REDMENOTEIP%

%KEENCMD% system configuration save

%KEENCMD% show running-config | grep "ip dhcp host"

echo The End of the Script %0
exit /b 0


