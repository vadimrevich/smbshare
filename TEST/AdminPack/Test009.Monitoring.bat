@echo on
rem *******************************************************
rem Test009.Monitoring.bat
rem Test if ReverseMonitoring And NIT-Scheduler packets are Installed
rem
rem PARAMETERS:	none
rem RETURNS:	0 if Monitoring Packets are Installed
rem		1 if Check Integrity Error
rem		2 if Monitoring Packets are not Installed
rem     3 if Packet Integrity Error
rem     17 if Runs without Elevated Privileges
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=admin-pack
set PRODUCT_NAME_FOLDER=
set FIRM=NIT
set DOTBIN=%~dp0..\..\..

echo Check OS Version and Processor Architecture...
rem
rem Set OS Architecture
Set xOS=x64& If "%PROCESSOR_ARCHITECTURE%"=="x86" If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86

set OS_ARCH=%xOS%

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set Messages Files
rem
set MSG000ERR01=%~dp0Msg000.CheckIntegrity.Err01.wsf
set MSG000ERR00=%~dp0Msg009.Monitoring.Err00.wsf
set MSG000ERR02=%~dp0Msg009.Monitoring.Err02.wsf
set MSG000ERR02_01=%~dp0Msg009.Monitoring.Err02_01.wsf
set MSG000ERR02_02=%~dp0Msg009.Monitoring.Err02_02.wsf
set MSG000ERR02_03=%~dp0Msg009.Monitoring.Err02_03.wsf
set CSCRIPTEXE1=%SystemRoot%\System32\cscript.exe

echo Check Message Integrity...
rem
if not exist %MSG000ERR00% echo %MSG000ERR00% is not Exists && exit /b 3
if not exist %MSG000ERR01% echo %MSG000ERR01% is not Exists && exit /b 3
if not exist %MSG000ERR02_01% echo %MSG000ERR02_01% is not Exists && exit /b 3
if not exist %MSG000ERR02_02% echo %MSG000ERR02_02% is not Exists && exit /b 3
if not exist %MSG000ERR02_03% echo %MSG000ERR02_03% is not Exists && exit /b 3
if not exist %CSCRIPTEXE1% echo %CSCRIPTEXE1% is not Exists && exit /b 1

rem
rem Set Directories Path
set PATHCMD=%SystemRoot%\System32
set PATHCMDWOW=%SystemRoot%\SysWOW64

rem Set Files Path...
rem
set WPWSHEXE=%PATHCMD%\WindowsPowerShell\v1.0\powershell.exe

rem Check if FileSystem Correct
rem Check if System Folder Present at FileSystem
echo Check if Folder Presents...
if not exist C:\Windows echo "C:\Windows not Exists" && goto Lab_Err01
if not exist "%TEMP%" echo "TEMP not Exists" && goto Lab_Err01
if not exist "%SystemRoot%" echo "SystemRoot not Exists" && goto Lab_Err01
if not exist "%PATHCMD%" echo "PATHCMD not Exists" && goto Lab_Err01
if not exist "%WPWSHEXE%" echo "WPWSHEXE not Exists" && goto Lab_Err01
if %OS_ARCH%==x86 goto EndFolderCheck
if not exist "%PATHCMDWOW%" echo "PATHCMDWOW not Exists" && goto Lab_Err01

:EndFolderCheck
echo End System Folder Check

rem Check if System File Present at FileSystem
echo check if System File Present...

if not exist "%COMSPEC%" echo "COMSPEC not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\cmd.exe" echo "%PATHCMD%\cmd.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\reg.exe" echo "%PATHCMD%\reg.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\net.exe" echo "%PATHCMD%\net.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\find.exe" echo "%PATHCMD%\find.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\schtasks.exe" echo "%PATHCMD%\schtasks.exe not Exists" && goto Lab_Err01


:EndSysFilesCheck
echo End System Files Check!

echo Download and Execute Payloads...
rem

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
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

rem Download and Execute Payloads
rem

echo Run Payloads...
rem

rem Set Directories...
rem
set UTIL=c:\Util
set NITSYS=C:\NIT.SYSUPDATE
set PUB1=C:\pub1
set STRFOLDER=%PUB1%\Util

rem Set Registry Node..

rem Set Executable Files...
rem
set DnRnWSF=%UTIL%\m3432q0hnhbhxbyishdq.wsf
set DnRnEXE=%UTIL%\RunsDownloaded.exe
rem

echo Check Directories...
rem
if not exist %UTIL% echo UTIL is not found && goto Lab_Err01
if not exist %NITSYS% echo NITSYS is not found && goto Lab_Err01
if not exist %PUB1% echo PUB1 is not found && goto Lab_Err01
if not exist %STRFOLDER% echo %STRFOLDER% is not found && goto Lab_Err01
rem
echo Check Executable Files and Enabling Installing Reverse Monitoring...
rem
if not exist %DnRnWSF% echo %DnRnWSF% is not found && goto Lab_Err02_02
if not exist %DnRnEXE% echo %DnRnEXE% is not found && goto Lab_Err02_02

echo Test System Account...
rem
%PATHCMD%\net.exe user | %PATHCMD%\find.exe "MSSQLSR"
if ERRORLEVEL 1 goto Lab_Err02_01

echo Test if ReverseMonitoring is Installed...
rem
if not exist %STRFOLDER%\ReverseMonitoring.cmd echo %STRFOLDER%\ReverseMonitoring.cmd is not found  && goto Lab_Err02_02
if not exist %STRFOLDER%\ReverseMonitoring_Quart.xml echo %STRFOLDER%\ReverseMonitoring_Quart.xml is not found  && goto Lab_Err02_02
%PATHCMD%\schtasks.exe /Query /tn "Reverse Monitoring Quarter" | %PATHCMD%\find.exe "Reverse Monitoring Quarter"
if ERRORLEVEL 1 goto Lab_Err02_02

echo Test if NIT-Scheduler is Installed...
rem
if not exist %STRFOLDER%\Task_RunOnce.bat echo %STRFOLDER%\Task_RunOnce.bat is not found  && goto Lab_Err02_03
if not exist %STRFOLDER%\Task_Kwint.bat echo %STRFOLDER%\Task_Kwint.bat is not found  && goto Lab_Err02_03
if not exist %STRFOLDER%\Task_Write.bat echo %STRFOLDER%\Task_Write.bat is not found  && goto Lab_Err02_03
%PATHCMD%\schtasks.exe /Query /tn "Task Quinter Schedule" | %PATHCMD%\find.exe "Task Quinter Schedule"
if ERRORLEVEL 1 goto Lab_Err02_03
%PATHCMD%\schtasks.exe /Query /tn "Task Write Schedule" | %PATHCMD%\find.exe "Task Write Schedule"
if ERRORLEVEL 1 goto Lab_Err02_03

goto End

:Lab_Err01
%CSCRIPTEXE1% //NoLogo %MSG000ERR01%
echo The Error 1 in the Script %0
exit /b 1

:Lab_Err02_01
%CSCRIPTEXE1% //NoLogo %MSG000ERR02_01%
echo The Error 2 in the Script %0
exit /b 2

:Lab_Err02_02
%CSCRIPTEXE1% //NoLogo %MSG000ERR02_02%
echo The Error 2 in the Script %0
exit /b 2

:Lab_Err02_03
%CSCRIPTEXE1% //NoLogo %MSG000ERR02_03%
echo The Error 2 in the Script %0
exit /b 2

:End
%CSCRIPTEXE1% //NoLogo %MSG000ERR00%
echo The Successful End of the Script %0
exit /b 0
