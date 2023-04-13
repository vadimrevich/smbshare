@echo on
rem *******************************************************
rem ip6-set-static-dns.cmd
rem This Script Sets IP6 DNS with Command Line
rem
rem Location: C:\.BIN
rem *******************************************************
@echo off

rem Define Local Variables (must be change)
set interface_name="Подключение по локальной сети"
set first_dns=
set second_dns=2001:4860:4860::8888
set third_dns=2001:4860:4860::8844

rem Code
@echo on
netsh interface ipv6 add dnsserver name=%interface_name% address=%first_dns% index=1
netsh interface ipv6 add dnsserver name=%interface_name% address=%second_dns% index=2
netsh interface ipv6 add dnsserver name=%interface_name% address=%third_dns% index=3


