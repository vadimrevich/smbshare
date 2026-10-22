@echo off
rem *******************************************************
rem nit.install-pwshcore.bat
rem *******************************************************
@echo off


rem Set a Variables
rem Initialization of Variables

rem Metadata

set PRODUCT_NAME=AutoRunScripts64
set SUBPRODUCT_NAME=Conditions
set PRODUCT_NAME_FOLDER=
set FIRM_NAME=NIT

setlocal EnableExtensions DisableDelayedExpansion

set "Reg32=%SystemRoot%\System32\reg.exe"
if not "%ProgramFiles(x86)%" == "" set "Reg32=%SystemRoot%\SysWOW64\reg.exe"

:EndBatch

rem Set a Variable

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End
echo Temp Folder = %TPDL%

set ScriptDir=%~dp0
set CurDir=%CD%
set InnerDir=%ScriptDir%

rem Set files

set POSHEXE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe
set CMDFILE001=%InnerDir%nit.install-pwshcore.bat
set POSHFILE001=%InnerDir%NIT.Install-Ssh.amd64.ps1
set POSHFILE002=%InnerDir%NIT.Set-SShRsaKeys.amd64.ps1
set WSCRIPTEXE=%SystemRoot%\System32\wscript.exe
set CHECKARCHBAT=%ScriptDir%CheckArch.bat
set CURLEXE=C:\Util\CURL.EXE
set UNZIPEXE=C:\Util\unzip.exe
set TAKEOWNEXE=%SystemRoot%\System32\takeown.exe

rem Check Integrity

if not exist %POSHEXE% echo A File %POSHEXE% is nit found && exit /b 1
rem if not exist %POSHFILE001% echo A File %POSHFILE001% is nit found && exit /b 1
rem if not exist %POSHFILE002% echo A File %POSHFILE002% is nit found && exit /b 1
if not exist %WSCRIPTEXE% echo A File %WSCRIPTEXE% is nit found && exit /b 1
if not exist %CHECKARCHBAT% echo A File %CHECKARCHBAT% is nit found && exit /b 1
if not exist %CURLEXE% echo A File %CURLEXE% is nit found && exit /b 1
if not exist %UNZIPEXE% echo A File %WUNZIPEXE% is nit found && exit /b 1
if not exist %TAKEOWNEXE% echo A File %TAKEOWNEXE% is nit found && exit /b 1

rem Check Run Amd64
call %CHECKARCHBAT%
if %errorlevel% NEQ 0 echo Run at x86 Architecture, Aborted && exit /b 1

rem Run Payloads

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
rem exit /b 17
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

rem Check if WinGet Installing
winget.exe --version
if %ERRORLEVEL% NEQ 0 echo winget is not installed && goto CheckChoco

:CheckChoco
choco.exe --version
if %ERRORLEVEL% NEQ 0 echo chocolatey is not installed && goto End
call %CMDFILE001%
%CURLEXE% http://win.netip4.ru/Apps/smbshare/NIT/atHost/Scripts/.ssh.zip -o %USERPROFILE%\.ssh.zip
%UNZIPEXE% -o %USERPROFILE%\.ssh.zip -d %USERPROFILE%
%TAKEOWNEXE% %USERPROFILE%\.ssh\ /R /D Y
%POSHEXE% -NoLogo -ExecutionPolicy Bypass -File %POSHFILE001%
%POSHEXE% -NoLogo -ExecutionPolicy Bypass -File %POSHFILE002%
goto End

:End
echo The end of the Script %0
exit /b 0