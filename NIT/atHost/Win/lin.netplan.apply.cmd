@echo off
rem *******************************************************
rem lin.netplan.apply.cmd
rem *******************************************************
@echo off

rem Set a Variables
rem
set PORT=22
set LOGIN=vagrant
set PASS=0a9s8d7F
set DOMAIN=lin.netip4.ru
set aCMD="sudo netplan apply"

rem Run a Payload
rem
klink -P %PORT% -pw %PASS% %LOGIN%@%DOMAIN% %aCMD%
