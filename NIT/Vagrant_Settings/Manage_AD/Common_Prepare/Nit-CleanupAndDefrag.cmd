@echo on
rem *******************************************************
rem NIT-CleanupAndDefrag.cmd
rem This Script wil Run Disk Creanup and Disk Defrag
rem Programs for System Drive
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=DiskUtilities
set REDACT=
set FIRM=NIT
set PRODUCT_FOLDER_REMOTE=%FIRM%/%PRODUCT_NAME%/

rem Set a Directory
rem

set CURDIR=%CD%
set pathCMD=%SystemRoot%\System32

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set a Files
rem
set CLEANUPEXE=%pathCMD%\cleanmgr.exe
set DEFRAGEXE=%pathCMD%\defrag.exe

rem Check Integrity
rem
if not exist %CLEANUPEXE% echo %CLEANUPEXE% is not Found && exit /b 1
if not exist %DEFRAGEXE% echo %DEFRAGEXE% is not Found && exit /b 1

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

echo Run Payloads...
rem

rem %CLEANUPEXE% /verylowdisk
%CLEANUPEXE% /SAGERUN:C
%DEFRAGEXE% C: /A
%DEFRAGEXE% C: /U /V /O

:End
echo The End of the Script %0
exit /b 0
