@echo off
rem *******************************************************
rem ASO_Reboot.cmd
rem This script will get an ASO Screen after system reboot
rem *******************************************************
@echo off

rem Set Variables
rem
set pathCMD=%SystemRoot%\System32
set SHUTDOWNEXE=%pathCMD%\shutdown.exe
set REAGENTCEXE=%pathCMD%\ReAgentc.exe

rem Check integrity...
rem
if not exist %SHUTDOWNEXE% echo %SHUTDOWNEXE% is not found && exit /b 1
if not exist %REAGENTCEXE% echo %REAGENTCEXE% is not found && exit /b 1

rem Run Payloads...
rem
rem Run Immediantly 
rem
%SHUTDOWNEXE%  /r /o /f /t 00
rem
rem Run Later
rem
rem %REAGENTCEXE% /boottore

:End
echo The End of the Script %0
exit /b 0
