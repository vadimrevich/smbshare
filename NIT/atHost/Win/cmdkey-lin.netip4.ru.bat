@echo on
rem *******************************************************
rem cmdkey-win.netip4.ru.bat
rem This Script will Add a Remote Host Credentials
rem The Script must be Run with Elevated Privileges
rem on Physical Host
rem *******************************************************
@echo off

rem The provided script is a Windows batch file 
rem (cmdkey-lin.netip4.ru.bat) designed to automate the configuration 
rem of remote host credentials on a Windows system. It runs with 
rem elevated (administrator) privileges and performs the following 
rem main functions:

rem Environment Setup:

rem Enables necessary batch extensions and sets up delayed variable expansion.
rem Defines a temporary directory path (TPDL) for storing auxiliary files, 
rem preferring a specific path if available, otherwise falling back to %TEMP%.

rem Remote Host Configuration:

rem Sets variables for a virtual machine hostname (LIN.netip4.ru), 
rem username (LIN\vagrant), and password (0a9s8d7F).

rem Connectivity Check:

rem Uses ping to verify network reachability of the target host 
rem (LIN.netip4.ru). If unreachable, the script exits with error code 2.

rem Elevation Check:

rem Checks if the script is running with administrative privileges 
rem using net session.
rem If not running as administrator, it attempts to re-launch 
rem itself with elevated rights using a dynamically generated VBScript 
rem (nit-*.vbs) that calls Shell.Application.ShellExecute with runas.

rem Credential Management:

rem Once running with admin rights, it uses cmdkey.exe to:
rem Remove any existing stored credentials for the target host.
rem Add new credentials (username and password) for the remote host, 
rem allowing future seamless authentication (e.g., for remote desktop 
rem or network connections).

rem In summary:

rem This script securely configures Windows to remember login 
rem credentials for a remote VM (LIN.netip4.ru) so that users 
rem or automated processes can connect without re-entering credentials, 
rem but only after confirming connectivity and obtaining 
rem administrative privileges.

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set a Variables
rem
set VMBIOS=LIN
set VMHOST=%VMBIOS%.netip4.ru
set VM_USER=%VMBIOS%\vagrant
set VM_PASS=0a9s8d7F

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
cmdkey.exe /DELETE:%VMHOST%
cmdkey.exe /ADD:%VMHOST% /USER:%VM_USER% /PASS:%VM_PASS%
