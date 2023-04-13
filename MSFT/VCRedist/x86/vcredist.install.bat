@echo on
rem *******************************************************
rem vcredist.install.bat
rem This Script Install the Visual C++ Redistributable
rem Packages and for .Net Framework 4.6.2+ Install
rem For Windows x86 only
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

set PRODUCT_NAME=VCRedist
set PRODUCT_NAME_FOLDER=
set FIRM_NAME=MSFT
set OS_ARCH=x86

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
set AFILE01=VCRHyb86.exe
set AFILE02=RuntimePack_Lite_x86_x64.exe

rem Check if FileSystem Correct
rem Clean and Make Downloaded Directory
rem
set PRODUCTNAMEDIR=%SMBSHARE0%\%FIRM_NAME%\%PRODUCT_NAME%\%OS_ARCH%

rem Derivatives Variables
set LocalFolder=%PRODUCTNAMEDIR%
set VCRHYB=%LocalFolder%\%AFILE01%
set RTPACK=%LocalFolder%\%AFILE02%

rem
echo Check Integrity...
rem
if not exist %PATHCMD% echo %PATHCMD% not Found && exit /b 1
if not exist %VCRHYB% echo %VCRHYB% not Found && exit /b 2
if not exist %RTPACK% echo %RTPACK% not Found && exit /b 2


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
%VCRHYB% /S 
%RTPACK% -y -gm2 -fm0

rem End Payloads

rem The End of the Script
:End
echo The End of the Script %0!
exit /b 0
