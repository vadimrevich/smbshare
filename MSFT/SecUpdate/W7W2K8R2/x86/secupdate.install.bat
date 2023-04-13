@echo on
rem *******************************************************
rem secupdate.install.bat
rem This Script Needs for Install Microsoft Trusted Root
rem Certificates and for .Net Framework 4.6.2+ Install
rem For Windows 7/2K8R2 x86 only
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

set PRODUCT_NAME=SecUpdate
set PRODUCT_NAME_FOLDER=W7W2K8R2
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
set WUSAEXE=%PATHCMD%\wusa.exe
set AFILE01=Windows6.1-KB2677070-x86.msu
set AFILE02=Windows6.1-KB2813430-x86.msu
set AFILE03=Windows6.1-KB3004394-v2-x86.msu
set AFILE04=Windows6.1-KB3063858-x86.msu

rem Check if FileSystem Correct
rem Clean and Make Downloaded Directory
rem
set PRODUCTNAMEDIR=%SMBSHARE0%\%FIRM_NAME%\%PRODUCT_NAME%\%PRODUCT_NAME_FOLDER%\%OS_ARCH%

rem Derivatives Variables
set LocalFolder=%PRODUCTNAMEDIR%
set MSUFILE01=%LocalFolder%\%AFILE01%
set MSUFILE02=%LocalFolder%\%AFILE02%
set MSUFILE03=%LocalFolder%\%AFILE03%
set MSUFILE04=%LocalFolder%\%AFILE04%

rem
echo Check Integrity...
rem
if not exist %PATHCMD% echo %PATHCMD% not Found && exit /b 1
if not exist %WUSAEXE% echo %WUSAEXE% not Found && exit /b 1
if not exist %MSUFILE01% echo %MSUFILE01% not Found && exit /b 2
if not exist %MSUFILE02% echo %MSUFILE02% not Found && exit /b 2
if not exist %MSUFILE03% echo %MSUFILE03% not Found && exit /b 2
if not exist %MSUFILE04% echo %MSUFILE04% not Found && exit /b 2


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
%WUSAEXE% "%MSUFILE01%" /quiet /norestart
%WUSAEXE% "%MSUFILE02%" /quiet /norestart
%WUSAEXE% "%MSUFILE03%" /quiet /norestart
%WUSAEXE% "%MSUFILE04%" /quiet /norestart

rem End Payloads

rem The End of the Script
:End
echo The End of the Script %0!
exit /b 0
