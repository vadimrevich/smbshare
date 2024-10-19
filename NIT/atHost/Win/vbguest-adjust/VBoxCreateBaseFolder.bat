@echo on
rem *******************************************************
rem VBoxCreateBaseFolder.bat
rem This Script will Create Base Folders for Oracle
rem VirtualBox Virtual Machines
rem
rem The Script must be Run with Elevated Privileges
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

rem Set Variables
rem
set VBoxBaseFolder=C:\VBox_VMS
set VBoxManageEXE="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
set VBoxEXE="C:\Program Files\Oracle\VirtualBox\VirtualBox.exe"


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

rem Create a Folder if not Set
rem
if exist %VBoxBaseFolder% goto :SKIP_BASEFOLDER

mkdir %VBoxBaseFolder%
echo %VBoxBaseFolder% is Created

:SKIP_BASEFOLDER

netsh advfirewall firewall delete rule name="VirtualBox Open Ports"
netsh advfirewall firewall add rule name="VirtualBox Open Ports" dir=in action=allow enable=yes program=%VBoxEXE%

exit /b 0
