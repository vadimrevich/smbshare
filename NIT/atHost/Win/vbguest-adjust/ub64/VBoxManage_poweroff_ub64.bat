@echo on
rem *******************************************************
rem VBoxManage.bat
rem This Script Call VBoxManage.exe for Oracle
rem VirtualBox CLI Manager
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
set GuestVM=ub64

set VBoxManageEXE="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
rem set CMDLINE="%*"
set CMDLINE="controlvm %GuestVM% poweroff"

rem Derivatives
set CMDLINE=%CMDLINE:"=%

rem Check Integrity
rem
if exist %VBoxBaseFolder% goto :SKIP_BASEFOLDER

echo %VBoxBaseFolder% is not Found
exit /b 1

:SKIP_BASEFOLDER

rem Run Payload
%VBoxManageEXE% %CMDLINE%
