@echo on
rem *******************************************************
rem nit-download-TinyExeFiles.MSI.cmd
rem This Script will Download the TinyExeFiles 
rem Packet witn Command Line Utilities
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=TinyExeFiles
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
set WorkingDir=%UserProfile%

rem Set Host
rem
set aPrefix=http
set aDomain=file.netip4.ru
set aPort=80
set aRemoteDir=/PROGS/%PRODUCT_FOLDER_REMOTE%

set host=%aPrefix%://%aDomain%:%aPort%%aRemoteDir%

rem Set a File Name
rem
set aFile=TinyExeFilesInstaller.msi

rem Download Payloads
rem
bitsadmin.exe /Transfer TinyExeFile /DOWNLOAD /PRIORITY FOREGROUND ^
%host%%aFile% %WorkingDir%\%aFile%

echo The End of the Script %0
exit /b 0
