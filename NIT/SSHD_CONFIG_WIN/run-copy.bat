@echo on
rem *******************************************************
rem run-copy.bat
rem This Script will copy a Public and Private SSH Keys at 
rem %UserProfile%\.ssh\
rem
rem PARAMETERS:	NONE
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
set rsaprivkey=ssh_host_rsa_key
set rsapubkey=ssh_host_rsa_key.pub
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

echo Create a %USERPROFILE%\.ssh directory
if not exist %USERPROFILE%\.ssh md %USERPROFILE%\.ssh

copy /Y /V %WORKINGPATH%\ssh_host_rsa_key %USERPROFILE%\.ssh\id_rsa
copy /Y /V %WORKINGPATH%\ssh_host_rsa_key.pub %USERPROFILE%\.ssh\id_rsa.pub
copy /Y /V %WORKINGPATH%\%vagprivkey% %USERPROFILE%\.ssh\%vagprivkey%
copy /Y /V %WORKINGPATH%\%vagpubkey% %USERPROFILE%\.ssh\%vagpubkey%

echo Grant Permissions...
icacls %USERPROFILE%\.ssh\*.* /remove:g *
icacls %USERPROFILE%\.ssh\*.* /remove:d *
icacls %USERPROFILE%\.ssh\*.* /grant:r %USERNAME%:F

echo Add a Vagrant private key...
ssh-add.exe %USERPROFILE%\.ssh\%vagprivkey%

echo Fix sshd...
%wpwshexe% -NoProfile -ExecutionPolicy Bypass -File %fixhost%
net stop sshd
net start sshd

:End
echo The Success End of the Script %0
exit /b 0
