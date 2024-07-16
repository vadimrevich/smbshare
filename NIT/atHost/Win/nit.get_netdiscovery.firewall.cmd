@echo on
rem *******************************************************
rem nit.get_netdiscovery.firewall.cmd
rem This Script will Set Net Discover Firewall Rule
rem *******************************************************
@echo off
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
netsh advfirewall firewall set rule group="Обнаружение сети" new enable=Yes
