@echo on
rem *******************************************************
rem setMyDocuments.w10.cmd
rem This Script will Set the Environments Variable
rem MyDocuments for Windows 10/11
rem
rem *******************************************************
@echo off

setlocal EnableExtensions DisableDelayedExpansion

rem Set a Variables
rem
set REGEXE=%SystemRoot%\System32\reg.exe

rem Check Integrity ...
rem
if not exist %COMSPEC% echo %COMSPEC% is not found && exit /b 1
if not exist %REGEXE% echo %REGEXE% is not found && exit /b 1

rem Set My Documents Variable...
rem
for /f "tokens=2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v Personal  ^|findstr /i "REG_"') do set MyDocuments=%%j

if not defined MyDocuments (echo Variable My Documents Folder not Defined && exit /b 1)
if not exist %MyDocuments% echo %MyDocuments% is not Found && exit /b 1

rem Run a Payload
rem

echo.
echo My Documents Shell Folder directory = %MyDocuments%
echo.

:End
echo Success Script %0 Runs
exit /b 0
