@echo on
rem *******************************************************
rem Uso.WindowsUpdate.cmd
rem Start Windows Update Procedure at Windows 11
rem You must start script with elevated Privileges
rem *******************************************************
@echo off

rem Set Variables
rem
set USOCLIENTEXE=%SystemRoot%\System32\UsoClient.exe

rem Check Integrity
if not exist %USOCLIENTEXE% echo %USOCLIENTEXE% is not found && exit /b 1

rem Run Payloads
%USOCLIENTEXE% StartScan
%USOCLIENTEXE% StartDownload
%USOCLIENTEXE% StartInstall
%USOCLIENTEXE% RestartDevice
%USOCLIENTEXE% ScanInstallWAit

rem The End
echo Success Script %0 Run!
exit /b 0
