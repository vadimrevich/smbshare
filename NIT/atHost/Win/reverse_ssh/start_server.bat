@echo off
rem *******************************************************
rem start-server.bat
rem This Script will start a Reverse SSH Server
rem on Windows Computer
rem
rem *******************************************************
@echo off

rem set Variables

set PORT=3232
set IPADDR=0.0.0.0
set EXT_ADDR="88.147.147.107:3232"
set EXT_ADDR=%EXT_ADDR:"=%

rem Run Payloads

.\server.exe --datadir . --insecure --external_address %EXT_ADDR% --log-level INFO %IPADDR%:%PORT%

 