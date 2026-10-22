@echo on
rem *******************************************************
rem run_setkey.bat
rem This Script will set a Publickey Authentication
rem at %1 host 
rem
rem PARAMETERS:	%1 <user>@<host> or localhost
rem RETURNS:	0 if Success Run
rem 		16 if Check Integrity Failed
rem
rem *******************************************************
@echo off

setlocal enableextensions enabledelayedexpansion

rem Metadata

set PRODUCT_NAME=SSHD_CONFIG_WIN
SET FIRM_NAME=NIT

echo Set Environments Settings...
rem
set WORKINGPATH=%AllUsersProfile%\ssh
set ChockPath=%ChocolateyInstall%\bin
set UTIL=C:\Util
rem Test
rem set WORKINGPATH=%~dp0ssh_test

echo Set Programs...
set CURLEXE=%UTIL%\curl.exe
set wpwshexe=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe

echo Set Files...
rem

set vagprivkey=vagrant
set vagpubkey=vagrant.pub

set fixhost="C:\Program Files\OpenSSH-Win64\FixHostFilePermissions.ps1"

echo Check Integrity...
rem
if not exist %WORKINGPATH%\sshd_config echo %WORKINGPATH%\sshd_config not found && exit /b 16
if not exist %ChockPath%\choco.exe echo %ChockPath%\choco.exe not found && exit /b 16
if not exist %CURLEXE% echo %CURLEXE% not found && exit /b 16
if not exist %wpwshexe% echo %wpwshexe% not found && exit / b 16
if not exist %fixhost% echo %fixhost% not found && exit /b 16

if not exist %ChockPath%\sed.exe echo %ChockPath%\sed.exe not found && exit /b 16

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
set getadminvbs=nit-configchange.vbs
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\%getadminvbs%"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\%getadminvbs%"

    %SystemRoot%\system32\wscript.exe "%temp%\%getadminvbs%"
    del "%temp%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

echo Check Host Parameter...
rem
set HOSTSSH=%~1
if not defined HOSTSSH (
	set HOSTSSH=localhost
) 
echo HOSTSSH = %HOSTSSH%

echo Add a Private Key %vagpubkey% at Host %HOSTSSH%...
type %USERPROFILE%\.ssh\%vagpubkey% | ssh %HOSTSSH% "cat >> .ssh/authorized_keys"

echo Fix sshd...
%wpwshexe% -NoProfile -ExecutionPolicy Bypass -File %fixhost%
net stop sshd
net start sshd

:End
echo The Success End of the Script %0
exit /b 0
