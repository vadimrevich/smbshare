@echo on
rem *******************************************************
rem Test006.Libs.bat
rem Test if Libs are Installed
rem
rem PARAMETERS:	none
rem RETURNS:	0 if Libs are Installed
rem		1 if Check Integrity Error
rem		2 if LIBS are not Installed
rem     3 if Packet Integrity Error
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
set MSG000ERR00=%~dp0Msg006.Libs.Err00.wsf
set MSG000ERR02=%~dp0Msg006.Libs.Err02.wsf
set MSG000ERR02_01=%~dp0Msg006.Libs.Err02_01.wsf
set MSG000ERR02_02=%~dp0Msg006.Libs.Err02_02.wsf
set MSG000ERR02_03=%~dp0Msg006.Libs.Err02_03.wsf
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

rem Check if FileSystem Correct
rem Check if System Folder Present at FileSystem
echo Check if Folder Presents...
if not exist C:\Windows echo "C:\Windows not Exists" && goto Lab_Err01
if not exist "%TEMP%" echo "TEMP not Exists" && goto Lab_Err01
if not exist "%SystemRoot%" echo "SystemRoot not Exists" && goto Lab_Err01
if not exist "%PATHCMD%" echo "PATHCMD not Exists" && goto Lab_Err01
if %OS_ARCH%==x86 goto EndFolderCheck
if not exist "%PATHCMDWOW%" echo "PATHCMDWOW not Exists" && goto Lab_Err01

:EndFolderCheck
echo End System Folder Check

rem Check if System File Present at FileSystem
echo check if System File Present...

if not exist "%COMSPEC%" echo "COMSPEC not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\cmd.exe" echo "%PATHCMD%\cmd.exe not Exists" && goto Lab_Err01
if not exist "%PATHCMD%\reg.exe" echo "%PATHCMD%\reg.exe not Exists" && goto Lab_Err01

:EndSysFilesCheck
echo End System Files Check!

echo Download and Execute Payloads...
rem

rem Set Directories...
rem
set UTIL=c:\Util
set NITSYS=C:\NIT.SYSUPDATE
set PUB1=C:\pub1

rem Set Registry Node..
set REGKEY_RUNONCE01="HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"
set REGKEY_RUNONCE02="HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\RunOnce"

rem Set Executed Script
set CHWSF=NIT-SU.wsf

echo Check Directories...
rem
if not exist %UTIL% echo UTIL is not found && goto Lab_Err01
if not exist %NITSYS% echo NITSYS is not found && goto Lab_Err01
if not exist %PUB1% echo PUB1 is not found && goto Lab_Err01

echo Check Files...
rem
if not exist %NITSYS%\%CHWSF% echo %NITSYS%\%CHWSF% is not found && goto Lab_Err01


echo Check Registry...
rem
rem Check if .NET Framework 4.0 Present
%PATHCMD%\reg.exe QUERY %REGKEY_RUNONCE01% /reg:64
if ERRORLEVEL 1 goto Lab_Err01
%PATHCMD%\reg.exe QUERY %REGKEY_RUNONCE02% /reg:64

echo Check Registry Key...
rem
%PATHCMD%\reg.exe QUERY %REGKEY_RUNONCE01% /reg:64 /v %CHWSF% | %PATHCMD%\find.exe "%PATHCMD%\wscript.exe //NoLogo %NITSYS%\%CHWSF%"
if %errorlevel% EQU 0 goto NextDep03
%PATHCMD%\reg.exe QUERY %REGKEY_RUNONCE02% /reg:64 /v %CHWSF% | %PATHCMD%\find.exe "%PATHCMD%\wscript.exe //NoLogo %NITSYS%\%CHWSF%"
if ERRORLEVEL 1 goto Lab_Err02_01


:NextDep03
echo Check if Auxiliary Libs and Files is Downloaded and Installed
rem
if not exist "%UTIL%\AutoHotkeyU32.exe" goto Lab_Err02_03
if not exist "%UTIL%\AutoHotkeyU64.exe" goto Lab_Err02_03
if not exist "%UTIL%\AutoIt3.exe" goto Lab_Err02_03
if not exist "%UTIL%\AutoIt3_x64.exe" goto Lab_Err02_03
goto NextDep04

:NextDep04
echo Check if ScriptLibs is Downloaded and Installed
rem
if not exist "%PUB1%\Distrib\LIB\LIB-JS\lib_func-1.0.0.js" goto Lab_Err02_02
if not exist "%PUB1%\Distrib\LIB\LIB-JS\lib_func-1.1.0.js" goto Lab_Err02_02
if not exist "%PUB1%\Distrib\LIB\LIB-JS\lib_check-1.0.0.js" goto Lab_Err02_02
if not exist "%PUB1%\Distrib\LIB\LIB-JS\lib_install-1.0.0.js" goto Lab_Err02_02
if not exist "%PUB1%\Distrib\LIB\LIB-JS\lib_smartinstall-1.0.0.js" goto Lab_Err02_02

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
