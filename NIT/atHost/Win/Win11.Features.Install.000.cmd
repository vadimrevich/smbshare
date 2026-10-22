@echo on
rem *******************************************************
rem Win11.Features.Install.cmd
rem Install WMIC, VBScript windows Features
rem The Script must be run with elevated privileges.
rem You must reboot system after Installation
rem 
rem *******************************************************
@echo off

rem Set a Variables
set DISMEXE=%SystemRoot%\System32\dism.exe

rem Check Integrity
if not exist %DISMEXE% echo %DISMEXE% is not found && exit /b 1

rem Run Payloads
%DISMEXE% /Online /Add-Capability /CapabilityName:WMIC~~~~
%DISMEXE% /Online /Add-Capability /CapabilityName:VBSCRIPT~~~~

rem The End
echo The End of the Script %0
exit /b 0
