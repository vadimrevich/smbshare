@echo on
rem *******************************************************
rem nit-install-TinyExeFiles.MSI.cmd
rem This Script will Install the TinyExeFiles 
rem Packet witn Command Line Utilities
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=TinyExeFiles
set REDACT=
set FIRM=NIT
set PRODUCT_FOLDER_REMOTE=%FIRM%/%PRODUCT_NAME%/

rem Set a Directory
rem

set CURDIR=%CD%

set ZLOVRED=C:\pub1\Distrib\Zlovred
set BINEXEDIR=C:\pub1\Distrib\BinExe
set INSTALLSCRIPT=CopyToUtil_00.cmd
set aMSG=%~dp0Msg.TinyExeFiles.Install.Success.wsf
set DOTBIN=C:\.BIN
set UTIL=C:\UTIL

echo Make Directories...
c:
cd \
md c:\pub1
md c:\pub1\Distrib
md c:\pub1\Distrib\Zlovred
md %ZLOVRED%
md %BINEXEDIR%
cd \
md %DOTBIN%
cd \
md %UTIL%

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set Working Directory (may be Changed)
rem
set WorkingDir=%UserProfile%

%~d0
cd %~p0
cd ..

rem Set Files...
rem
set CMDFILE001=%BINEXEDIR%\%INSTALLSCRIPT%
set WMICEXE=%SystemRoot%\System32\wbem\WMIC.exe
set WSCRIPTEXE=%SystemRoot%\System32\wscript.exe
set MSIEXECEXE=%SystemRoot%\System32\msiexec.exe

echo Check System Integrity...
rem
if not exist %WMICEXE% echo %WMICEXE% is not found && exit /b 1
if not exist %WSCRIPTEXE% echo %WSCRIPTEXE% is not found && exit /b 1
if not exist %MSIEXECEXE% echo %MSIEXECEXE% is not found && exit /b 1

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

cd /d %WorkingDir%
set SFXARCH=TinyExeFilesInstaller.msi
set SFXNAME="NIT-TinyExeFiles"
set FOLDER=.
if not exist "%FOLDER%\%SFXARCH%" goto Error
rem
echo Uninstall Previous Copy...
rem
%WMICEXE% product where name=%SFXNAME% call uninstall
rem
echo Install %SFXARCH%...
rem
%MSIEXECEXE% /i %SFXARCH% /qn /quiet /norestart /L*V %TPDL%\%SFXARCH%.log
rem %MSIEXECEXE% /i %SFXARCH% /qf /L*V %TPDL%\%SFXARCH%.log
goto Finish
:Error
echo "File %FOLDER%\%SFXARCH% not found" && exit /b 1
rem pause
:Finish

echo Check Integrity...
rem
if not exist %BINEXEDIR% echo %BINEXEDIR% is not found && exit /b 1
if not exist %ZLOVRED% echo %ZLOVRED% is not found && exit /b 1
if not exist %CMDFILE001% echo %CMDFILE001% is not found && exit /b 1

rem Download and Execute Payloads
rem

echo Run Payloads...

rem %WSCRIPTEXE% //NoLogo %CMDFILE001%
%COMSPEC% /c %CMDFILE001%

cd /d %CURDIR%
if exist %aMSG% Start %aMSG%

echo The End of the script %0
exit /b 0