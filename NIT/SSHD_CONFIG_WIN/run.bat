@echo on
rem *******************************************************
rem ssh_original_config_change.bat
rem This Script Changes the Original 
rem %AllUsersProfile%\ssh\sshd_config file:
rem * Change port to %1
rem * Add Insecure Vagrant Keys
rem * Add Powershell SSH Subsystem
rem * Make other Insecure Settings
rem
rem PARAMETERS:	%1 is a New Listen Port of SSH (22 is Default)
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
set rsaprivkey=vagrant
set rsapubkey=vagrant.pub
set ssgconfchange=ssh_config_change.sed.txt
set fixhost="C:\Program Files\OpenSSH-Win64\FixHostFilePermissions.ps1"

echo Check Integrity...
rem
if not exist %WORKINGPATH%\sshd_config echo %WORKINGPATH%\sshd_config not found && exit /b 16
if not exist %ChockPath%\cinst.exe echo %ChockPath%\sed.exe not found && exit /b 16
if not exist %CURLEXE% echo %CURLEXE% not found && exit /b 16
if not exist %wpwshexe% echo %wpwshexe% not found && exit / b 16
if not exist %fixhost% echo %fixhost% not found && exit /b 16

if not exist %ChockPath%\sed.exe echo %ChockPath%\sed.exe not found && exit /b 16

rem set Remote Folders
rem
set http_BaseDir01=/PROGS/
set http_ProgDir01=%http_BaseDir01%%FIRM_NAME%/%PRODUCT_NAME%/
set REG_FOLD=/Exponenta/Distrib/LIB/LIB-REG/
set CMD_FOLD=/Exponenta/Distrib/LIB-CMD/
set EXE_FOLD=/Exponenta/Distrib/LIB-EXE/
rem Set Hosts
rem
set http_pref01=http
set http_host01=file.netip4.ru
set http_port01=80
rem
echo Set Hosts...
rem
set host01=%http_pref01%://%http_host01%:%http_port01%%http_ProgDir01%

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
set getadminvbs=nit-configchange.vbs
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\%getadminvbs%"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\%getadminvbs%"

    %SystemRoot%\system32\wscript.exe "%temp%\%getadminvbs%"
    del "%temp%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

echo Create Backup Copy %WORKINGPATH%\sshd_config...
rem
if exist %WORKINGPATH%\sshd_config.bak del /Q /F %WORKINGPATH%\sshd_config.bak
copy %WORKINGPATH%\sshd_config %WORKINGPATH%\sshd_config.bak

echo Check Ports Parameter...
rem
set ListenPort=%~1
if not defined ListenPort (
	set ListenPort=22
) 
echo ListenPort = %ListenPort%

echo Download Vagrant Keys...
rem
%CURLEXE% %host01%%rsaprivkey% -o %WORKINGPATH%\ssh_host_rsa_key
%CURLEXE% %host01%%rsapubkey% -o %WORKINGPATH%\ssh_host_rsa_key.pub
%CURLEXE% %host01%%ssgconfchange% -o %~dp0%ssgconfchange%
%CURLEXE% %host01%%rsapubkey% >> %UserProfile%\.ssh\authorized_keys

echo Prepare sshd_config
%ChockPath%\sed.exe -f %~dp0%ssgconfchange% %WORKINGPATH%\sshd_config > %WORKINGPATH%\sshd_config.1
%ChockPath%\sed.exe "s/^\#Port 22/Port %ListenPort%/" %WORKINGPATH%\sshd_config.1 > %WORKINGPATH%\sshd_config
del /Q /F %WORKINGPATH%\sshd_config.1

echo Fix sshd...
%wpwshexe% -NoProfile -ExecutionPolicy Bypass -File %fixhost%
net stop sshd
net start sshd

:End
echo The Success End of the Script %0
exit /b 0
