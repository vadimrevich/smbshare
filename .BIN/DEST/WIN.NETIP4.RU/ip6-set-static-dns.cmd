@echo on
rem *******************************************************
rem ip6-set-static-dns.cmd
rem This Script Sets IP6 DNS with Command Line
rem
rem Location: C:\.BIN
rem *******************************************************
@echo off

rem Define Local Variables (must be change)
set interface_name="Ethernet"
set first_dns=2001:4860:4860::8844
set second_dns=2001:4860:4860::8888
set third_dns=

rem Code
@echo on
netsh interface ipv6 add dnsserver name=%interface_name% address=%first_dns% index=1
netsh interface ipv6 add dnsserver name=%interface_name% address=%second_dns% index=2
rem netsh interface ipv6 add dnsserver name=%interface_name% address=%third_dns% index=3


