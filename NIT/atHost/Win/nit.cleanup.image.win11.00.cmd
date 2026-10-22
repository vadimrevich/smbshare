@echo off
rem *******************************************************
rem nit.cleanup.image.win11.00.cmd
rem This Script will CleanUP Fresh Windows 11 Installing
rem It will Delete Restore Points, Temprorary Files, etc.
rem
rem *******************************************************
@echo off

rem Set Variables
set poshScript000=%~dp0CleanupUserProfile.ps1
set poshScript001=%~dp0NIT.Remove-DefMetroApps.00.ps1

set POSHEXE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe

rem Run Payloads

rem Remove Predefined Metro Applications
if exist %poshScript001% %POSHEXE% -NoProfile -Window Normal -ExecutionPolicy Bypass -File %poshScript001%

rem Remove Shadow Copies
vssadmin delete shadows /All /Quiet

Rem Clean Up Windows Updates and Components
Dism.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase
del %windir%\SoftwareDistribution\Download\*.* /f /s /q

rem Clear User Cache and Downloads
if exist %poshScript000% %POSHEXE% -NoProfile -Window Normal -ExecutionPolicy Bypass -File %poshScript000%

rem Clean With CleanMgr
Cleanmgr /sagerun:1

rem Remove Windows Logs
for /F "tokens=*" %l in ('wevtutil.exe el') DO wevtutil.exe cl "%l"

rem Clean Recycle Bin
%POSHEXE% -NoProfile -Window Normal -ExecutionPolicy Bypass -Command "Clear-RecycleBin -Force"

