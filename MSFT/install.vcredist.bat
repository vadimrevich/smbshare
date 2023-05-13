@echo on
rem *******************************************************
rem install.secupdate.bat
rem This Script Checks and Installs SecUpdate
rem Packages
rem For Windows W7W2K8R2 only
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

set PRODUCT_NAME=
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
set PROD_DIR0=VCRedist
set MESSAGDIR=MESSAGES

rem Set Files and Paths...
set AFILE01=vcredist.install.bat
set AFILE02=MESSWIN7-VCRedist01.wsf
rem
echo Set System Files...
rem
set FINDEXE=%PATHCMD%\find.exe
set CSCRIPTEXE=%PATHCMD%\cscript.exe
set SHUTDOWNEXE=%PATHCMD%\shutdown.exe
rem
rem Set Derivatives...
rem
set PRMESSDIR=%~dp0%MESSAGDIR%
set PRMESS01=%PRMESSDIR%\%AFILE02%
rem
echo Check System Integrity...
rem
if not exist %PATHCMD% echo %PATHCMD% not Found && exit /b 1
if not exist %FINDEXE% echo %FINDEXE% not Found && exit /b 2
if not exist %CSCRIPTEXE% echo %CSCRIPTEXE% not Found && exit /b 2
if not exist %SHUTDOWNEXE% echo %SHUTDOWNEXE% not Found && exit /b 2
if not exist %PRMESS01% echo %PRMESS01% not Found && exit /b 2

echo Check OS Version and Processor Architecture...
rem
rem Set OS Architecture
Set xOS=x64& If "%PROCESSOR_ARCHITECTURE%"=="x86" If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86

rem Check if FileSystem Correct
rem Clean and Make Downloaded Directory
rem
set PRODUCTNAMEDIR=%~dp0%PROD_DIR0%\%xOS%

rem Derivatives Variables
set LocalFolder=%PRODUCTNAMEDIR%
set CMDFILE01=%LocalFolder%\%AFILE01%

rem
echo Check Integrity...
rem
if not exist %CMDFILE01% echo %CMDFILE01% not Found && exit /b 2

%CSCRIPTEXE% //NoLogo %PRMESS01%

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
call %CMDFILE01%
if %errorlevel% neq 0 goto End
echo The End Script %0. Restarting Computer...
%SHUTDOWNEXE% /r /t 15

rem End Payloads

rem The End of the Script
:End
echo The End of the Script %0!
exit /b 0
