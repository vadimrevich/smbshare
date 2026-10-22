@echo off
rem *******************************************************
rem nit.install-rdpwrap.bat
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

set WSCRIPTEXE=%SystemRoot%\System32\wscript.exe
set CHECKARCHBAT=%ScriptDir%CheckArch.bat
set CURLEXE=C:\Util\CURL.EXE
set UNZIPEXE=C:\Util\unzip.exe
set TAKEOWNEXE=%SystemRoot%\System32\takeown.exe

rem Check Integrity

if not exist %POSHEXE% echo A File %POSHEXE% is nit found && exit /b 1

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
%POSHEXE% -NoLogo -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\RDP Wrapper'"
%CURLEXE% -o "%TPDL%\RDP_Wrapper_install.zip" http://file.netip4.ru:80/PROGS/STASM/RDPWrap/download.php?file=RDP_Wrapper_install.zip
%UNZIPEXE% -o "%TPDL%\RDP_Wrapper_install.zip" -d "C:\Program Files"  
cd "C:\Program Files\RDP Wrapper\helper"
call .\autoupdate__enable_autorun_on_startup.bat
cd ..
call .\install.bat
call .\autoupdate.bat

goto End

:End
echo The end of the Script %0
exit /b 0