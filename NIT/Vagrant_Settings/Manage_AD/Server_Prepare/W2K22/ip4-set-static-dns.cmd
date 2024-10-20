@echo on
rem *******************************************************
rem ip4-set-static-dns.cmd
rem This Script Sets IP4 DNS with Command Line
rem
rem Location: C:\.BIN
rem *******************************************************
@echo off

rem Define Local Variables (must be change)
set interface_name="Ethernet0"
set first_dns=192.168.252.10
set second_dns=192.168.252.1
set third_dns=8.8.8.8

rem Code
@echo on
netsh interface ip set dns %interface_name% static %first_dns%
netsh interface ip add dns %interface_name% %second_dns%
netsh interface ip add dns %interface_name% %third_dns% index=3


