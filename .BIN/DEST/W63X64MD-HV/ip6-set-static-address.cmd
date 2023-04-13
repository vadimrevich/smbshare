@echo on
rem *******************************************************
rem ip6-set-static-address.cmd
rem This Script Sets IP6 Protocol with Command Line
rem
rem Location: C:\.BIN
rem *******************************************************
@echo off

rem Define Local Variables (must be change)
set interface_name="Ethernet"
set ip_address=
set ip_mask=
set ip_gateway=

rem Code
@echo on
netsh interface ipv6 add address interface=%interface_name% address=%ip_address%/%ip_mask%
netsh interface ipv6 add route ::/0 interface-%interface_name% nexthop=%ip_gateway%

