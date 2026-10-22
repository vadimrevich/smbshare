@echo off
rem *******************************************************
rem Dameware Mini Remote Control.bar
rem *******************************************************
@echo off

rem Set Variables
rem
set aRunExe="C:\Program Files (x86)\SolarWinds\DameWare Remote Support\DWRCC.exe"

rem Run Payloads
%COMSPEC% /c %aRunExe%

echo The end of the Script %0
exit /b 0
