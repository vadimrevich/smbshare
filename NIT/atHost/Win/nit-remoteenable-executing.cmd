@echo on
rem *******************************************************
rem nit-remoteenable-executing.cmd
rem This Script will Run the Commands for Enabling 
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
rem set WorkingDir=%SystemRoot%
set WorkingDir=%UserProfile%

rem Run Payloads
powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -File %WorkingDir%\Set-AllPublicNetworksAsPrivate.ps1
call %WorkingDir%\adAdminLocal.cmd
call %WorkingDir%\adAdminDomain.cmd
rem call %WorkingDir%\adResetPassword.cmd
call %WorkingDir%\nit-enable-WMISMBFirewall.cmd
call %WorkingDir%\nit-enable-PSremoting.bat
powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -File %WorkingDir%\Enable-RDPWindows.ps1

echo The End of the Script %0
exit /b 0


