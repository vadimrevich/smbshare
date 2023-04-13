@echo on
rem *******************************************************
rem dotnet.install.bat
rem This Script Install the .Net Framework 4.6.2 and 4.8
rem Packages
rem For Windows only
rem The System Needs Restart after Installation
rem
rem RETURNS:	0 if Success
rem		1 if Check Integrity Folder Error
rem		2 if Check Integrity File Error
rem		17 if Needs Admin Privileges
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=dotNet
set PRODUCT_NAME_FOLDER=
set FIRM_NAME=MSFT
set OS_ARCH=

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem
rem Set Directories Path
set PATHCMD=%SystemRoot%\System32
set PATHCMDWOW=%SystemRoot%\SysWOW64
set curdirforurl=%CD%
set SMBSHARE0=C:\.BIN\smbshare

rem Set Files and Paths...
set AFILE01=NDP462-KB3151800-x86-x64-AllOS-ENU.exe
set AFILE02=ndp48-x86-x64-allos-enu.exe

rem Check if FileSystem Correct
rem Clean and Make Downloaded Directory
rem
set PRODUCTNAMEDIR=%SMBSHARE0%\%FIRM_NAME%\%PRODUCT_NAME%

rem Derivatives Variables
set LocalFolder=%PRODUCTNAMEDIR%
set NDP462=%LocalFolder%\%AFILE01%
set NDP48=%LocalFolder%\%AFILE02%

rem
echo Check Integrity...
rem
if not exist %PATHCMD% echo %PATHCMD% not Found && exit /b 1
if not exist %NDP462% echo %NDP462% not Found && exit /b 2
if not exist %NDP48% echo %NDP48% not Found && exit /b 2


rem
echo Download and Run Payloads...
rem
title Installing Packages
::-------------------------------------
REM  --> CheckING for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
rem Lock Data
exit /b 17
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

rem Download and Execute Payloads
rem

echo Run Payloads...

rem
%NDP462% /quiet /norestart 
%NDP48% /quiet /norestart

rem End Payloads

rem The End of the Script
:End
echo The End of the Script %0!
exit /b 0
