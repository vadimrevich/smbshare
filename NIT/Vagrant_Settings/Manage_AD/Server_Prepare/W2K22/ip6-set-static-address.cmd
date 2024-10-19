@echo on
rem *******************************************************
rem ip6-set-static-address.cmd
rem This Script Sets IP6 Protocol with Command Line
rem
rem Location: C:\.BIN
rem *******************************************************
@echo off

rem Define Local Variables (must be change)
set interface_name="Ethernet0"
set ip_address=192.168.252.10
set ip_mask=255.255.255.0
set ip_gateway=192.168.252.1

rem Code
@echo on
netsh interface ipv6 add address interface=%interface_name% address=%ip_address%/%ip_mask%
netsh interface ipv6 add route ::/0 interface=%interface_name% nexthop=%ip_gateway%

