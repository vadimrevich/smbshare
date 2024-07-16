@echo on
rem *******************************************************
rem run-CmdInDownloads.w10.cmd
rem This Script will run the Command Shell in the Folder
rem Downloads for Windows 10/11
rem
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Set a Directory
rem

set CURDIR=%CD%

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set a Variables
rem
set REGEXE=%SystemRoot%\System32\reg.exe

rem Check Integrity...
if not exist %REGEXE% echo %REGEXE% is not Found && exit /b 1
if not exist %COMSPEC% echo %COMSPEC% is not Found && exit /b 1

rem Set DownloadShellFolder Variable...
rem
FOR /f "tokens=3" %%Z in ('%REGEXE% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{374DE290-123F-4565-9164-39C4925E467B}" ^|findstr /i "REG_"') do SET DownloadShellFolder=%%Z

if not defined DownloadShellFolder (echo Variable Download Shell Folder not Defined && exit /b 1)
if not exist %DownloadShellFolder% echo %DownloadShellFolder% is not Found && exit /b 1

rem Set My Documents Variable...
rem
for /f "tokens=2,*" %%i in ('%REGEXE% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v Personal  ^|findstr /i "REG_"') do set MyDocuments=%%j

if not defined MyDocuments (echo Variable My Documents Folder not Defined && exit /b 1)
if not exist %MyDocuments% echo %MyDocuments% is not Found && exit /b 1

rem Check UserProfile Variable...
rem
if not defined UserProfile (echo Variable UserProfile Folder not Defined && exit /b 1)
if not exist %UserProfile% echo %UserProfile% is not Found && exit /b 1

echo Download and Run Payload..
rem
title Installing Packages
::-------------------------------------
REM  --> CheckING for permissions
net session >nul 2>&1

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
rem Lock Data
rem exit /b 17
rem
set getadminvbs=nit-%~n0.vbs
    echo Set UAC = CreateObject^("Shell.Application"^) > "%TPDL%\%getadminvbs%"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

rem Run a Payload
rem

echo True
start %COMSPEC% /k cd /d %DownloadShellFolder%

