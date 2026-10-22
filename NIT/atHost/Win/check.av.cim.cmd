@echo off
rem *******************************************************
rem check.av.wmic.cmd
rem This Script will Check if any Antivirus install at
rem the Microsoft Windows Operation System
rem
rem Function Return:
rem	0 if Success Run
rem	1 if integrity Error Occur
rem *******************************************************
@echo off

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set a Variables
set pathCMD=%SystemRoot%\System32
set POSHEXE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe
set CIMPS1=%~dp0NIT.Check-AVCim.ps1

rem Check Integrity...
if not exist %POSHEXE% echo %POSHEXE% is not Found && exit /b 1
if not exist %CIMPS1% echo %CIMPS1% is not Found && exit /b 1

rem Run Payload...

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

%POSHEXE% -NoLogo -NoProfile -ExecutionPolicy Bypass -File %CIMPS1%
rem @echo No Antivirus installed