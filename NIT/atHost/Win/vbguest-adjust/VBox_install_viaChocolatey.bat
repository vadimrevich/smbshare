@echo on
rem *******************************************************
rem VBox_install_viaChocolatey.bat
rem This Script will Install Oracle VirtualBox
rem Virtual Machine on Windows Computer
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=VBoxManagements
set REDACT=
set FIRM=NIT
set PRODUCT_FOLDER_REMOTE=%FIRM%/%PRODUCT_NAME%/

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem set Files
set CHOCOEXE=%chocolateyinstall%\choco.exe
set VBoxManageEXE="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
set WINGETEXE=winget

rem Check Integrity
rem
set wingetExists=false && winget -v && set wingetExists=true

if not exist %CHOCOEXE% echo %CHOCOEXE% is not found && exit /b 1
rem if wingetExists==false echo %WGETEXE% is not found && exit /b 1

rem
echo Download and Run Payloads...
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
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 0 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

rem Run Payload


rem Update Virtualbox
%CHOCOEXE% install -y VirtualBox
rem %WINGETEXE% install Oracle.VirtualBox --source winget

exit /b 0
