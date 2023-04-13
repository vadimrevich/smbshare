@echo on
rem *******************************************************
rem dockerNetwork-ExternalNetwork-ConfigOnly.001.bat.txt
rem This Script Create External (driver transparent)
rem Config-Only Docker Network on Windows Host
rem *******************************************************
@echo off

rem Set Hosts
rem
set aRouterIP=192.168.252.1
set aRouterSubnet=192.168.252.0/24
set aRouterName=Keenetic-Giga
set aSubnetDNSSuffix=yudenisov.internal
set anInterFaceName="vEthernet (External)"
set aHostIP=192.168.252.17
set aHostMask=255.255.255.0
set aHostName=LAPTOP-VG

rem set a Driver Param
set aNetDriver=transparent

rem Set Subnet and Gateway
set aSubnet=%aRouterSubnet%
set aGateway=%aRouterIP%

rem Set DNS Servers
set aPrimaryDNS=%aRouterIP%
set aSecondaryDNS=8.8.8.8
set aThirdlyDNS=8.8.4.4

@echo on
rem Run Docker Network Command
docker network create ^
--config-only ^
-d "%aNetDriver%" ^
--subnet %aSubnet% ^
--gateway %aGateway% ^
--ipv6 ^
-o com.docker.network.windowsshim.dnsservers="%aPrimaryDNS%,%aSecondaryDNS%,%aThirdlyDNS%" ^
-o com.docker.network.windowsshim.interface=%anInterFaceName% ^
-o com.docker.network.windowsshim.dnssuffix=%aSubnetDNSSuffix% ^
ExtNet001Config