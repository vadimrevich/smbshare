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
rem set POSHFILE001=%InnerDir%IEHArden_V5.bat
rem set POSHFILE002=%InnerDir%WinRM2Unsafe.bat
set WSCRIPTEXE=%SystemRoot%\System32\wscript.exe
rem set CHECKARCHBAT=%ScriptDir%CheckArch.bat

rem Check Integrity

if not exist %POSHEXE% echo A File %POSHEXE% is nit found && exit /b 1
rem if not exist %POSHFILE001% echo A File %POSHFILE001% is nit found && exit /b 1
rem if not exist %POSHFILE002% echo A File %POSHFILE002% is nit found && exit /b 1
if not exist %WSCRIPTEXE% echo A File %WSCRIPTEXE% is nit found && exit /b 1
rem if not exist %CHECKARCHBAT% echo A File %CHECKARCHBAT% is nit found && exit /b 1

rem Check Run Amd64
rem call %CHECKARCHBAT%
rem if %errorlevel% NEQ 0 echo Run at x86 Architecture, Aborted && exit /b 1

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
winget install Microsoft.PowerShell --source winget
goto End

:CheckChoco
choco.exe --version
if %ERRORLEVEL% NEQ 0 echo chocolatey is not installed && goto End
choco install -y powershell-core
goto End

:End
echo The end of the Script %0
exit /b 0