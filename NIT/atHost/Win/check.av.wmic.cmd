@echo off
rem *******************************************************
rem check.av.wmic.cmd
rem This Script will Check if any Antivirus install at
rem the Microsoft Windows Operation System
rem
rem Function Return:
rem	0 if Success Run
rem	1 if integrity Error Occur
rem *******************************************************
@echo off

rem Set a Variables
set pathCMD=%SystemRoot%\System32
set WMICEXE=%pathCMD%\WBem\WMIC.exe

rem Check Integrity...
if not exist %WMICEXE% echo %WMICEXE% is not Found && exit /b 1

rem Run Payload...

%WMICEXE% /node:localhost /namespace:\\root\SecurityCenter2 path AntiVirusProduct Get DisplayName | findstr /V /B /C:displayName || echo No Antivirus installed
rem @echo No Antivirus installed