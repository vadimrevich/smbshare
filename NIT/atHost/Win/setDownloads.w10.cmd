@echo on
rem *******************************************************
rem setDownloads.w10.cmd
rem This Script will Set the Environments Variable
rem Downloads for Windows 10/11
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

rem Set DownloadShellFolder Variable...
rem
FOR /f "tokens=3" %%Z in ('%REGEXE% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{374DE290-123F-4565-9164-39C4925E467B}" ^|findstr /i "REG_"') do SET DownloadShellFolder=%%Z

if not defined DownloadShellFolder (echo Variable Download Shell Folder not Defined && exit /b 1)
if not exist %DownloadShellFolder% echo %DownloadShellFolder% is not Found && exit /b 1

rem Run a Payload
rem

echo.
echo Download Shell Folder directory = %DownloadShellFolder%
echo.

:End
echo Success Script %0 Runs
exit /b 0
