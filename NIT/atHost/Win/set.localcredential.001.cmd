@echo off
rem *******************************************************
rem set.localcredential.cmd
rem This Script will run set default windows credentials
rem  for a slave computer at master computer
rem The script must be run with elevated privileges
rem
rem PARAMETERS: %1 slave host name or IP
rem
rem *******************************************************
@echo off

IF "%~1"=="" GOTO Usage

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem set Variables

set PINGEXE=%SystemRoot%\System32\ping.exe
set POSHEXE=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
set COMPNAME=%1
set WSCRIPTEXE=%SystemRoot%\System32%\wscript.exe
set CMDKEYEXE=%SystemRoot%\System32\cmdkey.exe

rem Set Credentials
rem set USERNAME=MSSQLSR
rem set PASSWORD=Admin01234
set USERNAME=vagrant
set PASSWORD=vagrant
rem set USERNAME=user
rem set PASSWORD=P@ssp0rtSaratov

rem Check Integrity

if not exist %PINGEXE% echo The file %PINGEXE% is not found && exit /b 1
if not exist %POSHEXE% echo The file %POSHEXE% is not found && exit /b 1
if not exist %WSCRIPTEXE% echo The file %WSCRIPTEXE% is not found && exit /b 1
if not exist %CMDKEYEXE% echo The file %CMDKEYEXE% is not found && exit /b 1

%PINGEXE% -n 2 -4 %COMPNAME% > nul 2> nul
if %errorlevel% NEQ 0 echo Cannot connect to %COMPNAME% && exit /b 2

rem
title Check the Elevated Privileges
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
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 0 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

rem Run Payload

%CMDKEYEXE% /DELETE:%COMPNAME%
%CMDKEYEXE% /generic:%COMPNAME% /user:%USERNAME% /pass:%PASSWORD%

goto End

:Usage
echo "Usage: %0 <host name or IP>"
exit /B 1

:End
echo The script %0 is terminated Successfully.
exit /b 0
