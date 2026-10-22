@echo on
rem *******************************************************
rem cmdkey-laptop-vg.bat
rem This Script will Add a Local Host Credentials
rem The Script must be Run with Elevated Privileges
rem on Physical Host
rem *******************************************************
@echo off

rem This script silently installs login credentials for a local VM host, 
rem after verifying connectivity and obtaining admin rights.

rem Summary of Functionality (English)
rem This Windows batch script is designed to add stored credentials 
rem for a local virtual machine host using the cmdkey command. 
rem It ensures that the user can authenticate automatically when 
rem connecting to the specified host (e.g., via Remote Desktop 
rem or network shares).

rem Key behaviors:

rem Sets up environment variables for the target host (LAPTOP-EURTP), 
rem its domain-qualified name, and login credentials.
rem Checks if the target host is reachable via ping.
rem Ensures the script is running with administrator privileges — 
rem if not, it attempts to elevate itself using a temporary VBScript 
rem that triggers a UAC prompt.
rem Once elevated, it:
rem Removes any existing stored credentials for the host using cmdkey /DELETE:...
rem Adds new credentials using cmdkey /ADD:... with a predefined 
rem username and password.

rem The credentials are stored in Windows Credential Manager and can be 
rem used later by other tools or services needing access to the specified machine.


rem Note: The script contains hardcoded credentials, which is a security risk. 
rem Also, parts of the elevation logic appear incomplete or potentially 
rem obfuscated (e.g., the goto TPDL_End skips over VBS creation code), 
rem suggesting possible corruption or intentional hiding of behavior.

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set a Variables
rem
set VMBIOS=LAPTOP-EURTP
set VMHOST=%VMBIOS%.yudenisov.internal
set VM_USER=%VMBIOS%\user
set VM_PASS=0A9s8d7F

rem Test if Host Present
rem
ping.exe -n 2 -4 %VMHOST% > nul 2> nul
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
cmdkey.exe /DELETE:%VMBIOS%
cmdkey.exe /ADD:%VMBIOS% /USER:%VM_USER% /PASS:%VM_PASS%
cmdkey.exe /DELETE:%VMHOST%
cmdkey.exe /ADD:%VMHOST% /USER:%VM_USER% /PASS:%VM_PASS%
