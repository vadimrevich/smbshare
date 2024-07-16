@echo on
rem *******************************************************
rem cmdkey-win.netip4.ru.bat
rem This Script will Add a Remote Host Credentials
rem The Script must be Run with Elevated Privileges
rem on Physical Host
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set a Variables
rem
set VMHOST=win.netip4.ru
set VM_USER=%VMHOST%\vagrant
set VM_PASS=0a9s8d7F

rem Test if Host Present
rem
ping.exe -n 2 -6 %VMHOST% > nul 2> nul
if %errorlevel% NEQ 0 echo Cannot connect to %VMHOST% && exit /b 2

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

rem Run a Payload
rem
cmdkey.exe /DELETE:%VMHOST%
cmdkey.exe /ADD:%VMHOST% /USER:%VM_USER% /PASS:%VM_PASS%