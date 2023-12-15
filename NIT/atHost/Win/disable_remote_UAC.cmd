@echo on
rem *******************************************************
rem disable_remote_UAC.cmd
rem This Script will Disable Remote UAC Filter 
rem on Local Computer
rem
rem PARAMETERS:	NONE
rem RETURNS:	0 if success run
rem		1 if Check Integrity Error
rem		17 if Run without Elevated Privileges
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Set a Directory
rem

set CURDIR=%CD%

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set a Vatiable

set pathCMD=%SystemRoot%\system32
set REGEXE=%pathCMD%\reg.exe
set RegistryNode="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
set RegistryKey="LocalAccountTokenFilterPolicy"

echo Check System Integrity....
rem
if not exist %REGEXE% echo %REGEXE% is not Found! && exit /b 1
rem
rem Check if %RegistryNode% is Exist...
%REGEXE% query %RegistryNode% > nul 2>&1
if %errorlevel% NEQ 0 echo %RegistryNode% is not Found! && exit /b 1

echo Download and Run Payload..
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
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

%REGEXE% add %RegistryNode% /v %RegistryKey% /t REG_DWORD /d 1 /f
if %errorlevel% NEQ 0 exit /b 1

rem The End of the Script
echo Script %0 is Run Successfully!
exit /b 0
