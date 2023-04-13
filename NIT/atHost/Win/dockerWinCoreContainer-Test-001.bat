@echo on
rem *******************************************************
rem dockerWinCoreContainer-Test-001.bat
rem This Script Creates Simple Docker Container on Windows
rem Core ltsc2022 with HostName and Static IP
rem *******************************************************
@echo off

rem Set Hosts Parameters
rem
set aHostIP=172.27.16.1
set aHostName=LAPTOP-VG

rem set Network Variables
rem
set aNetworkName=nat
set aNetworkSubnet=172.27.16.0/20
set aNetworkGateway=%aHostIP%
set aPrimaryDNS=8.8.8.8
set aSecondaryDNS=8.8.4.4

rem set Guest Parameters
rem
set aGuestName=W2K22C-TEST
set aGuestIP=172.27.16.3
set aGuestNetName=%aNetworkName%
set aGuestContName=w2k22ctest

rem Set Image Specified Fields
set anImage=mcr.microsoft.com/windows/servercore:ltsc2022
set aCommand=cmd.exe
set aWorkingDir="C:\Users\ContainerAdministrator"

@echo on
rem Create Container
docker run ^
--name %aGuestContName% ^
-it ^
-h %aGuestName% ^
--network nat ^
--ip %aGuestIP% ^
--dns %aPrimaryDNS% ^
--dns %aSecondaryDNS% ^
--pull never ^
-w %aWorkingDir% ^
%anImage% ^
%aCommand%
