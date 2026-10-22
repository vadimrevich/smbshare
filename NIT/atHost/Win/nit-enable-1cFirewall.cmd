@echo on
rem *******************************************************
rem nit-enable-WMISMBFirewall.cmd
rem Tis Script will Enable a Firewall Rules
rem on local Windows Computer
rem via Windows Shell
rem *******************************************************

rem Set Windows Managements Instrumentation
rem netsh.exe advfirewall firewall set rule group="windows management instrumentation (wmi)" new enable=yes

@echo off
rem Delete Users Rules
netsh.exe advfirewall firewall delete rule name="Allow 1C Server Ports"

rem Set Additional Instrumentation
rem netsh.exe advfirewall firewall add rule dir=in name="Add Local RDP Port 3389 Firewall Rule" action=allow protocol=TCP localport=3389
powershell -NoProfile  -NoLogo -ExecutionPolicy Bypass -Command "New-NetFirewallRule -DisplayName 'Allow 1C Server Ports' -Direction Inbound -Profile Any -Action Allow -Protocol TCP -LocalPort 80,443,1433,1540,1541,1545,1560-1591,5432"
powershell -NoProfile  -NoLogo -ExecutionPolicy Bypass -Command "New-NetFirewallRule -DisplayName 'Allow 1C Server Ports' -Direction Inbound -Profile Any -Action Allow -Protocol UDP -LocalPort 1434"

