@echo on
rem *******************************************************
rem Test001.dotNet3.bat
rem Test if dotNet 3.5 is Installed
rem
rem PARAMETERS:	none
rem RETURNS:	0 if .NET Framework is Installed
rem		1 if Check Integrity Error
rem		2 if .NET Framework is not Installed
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

rem Set Messages Files
rem
set MSG000ERR01=%~dp0Msg000.CheckIntegrity.Err01.wsf
set MSG000ERR00=%~dp0Msg001.dotNet03.Err00.wsf
set MSG000ERR02=%~dp0Msg001.dotNet3.Err02.wsf
set CSCRIPTEXE1=%SystemRoot%\System32\cscript.exe

echo Check Message Integrity...
rem
if not exist %MSG000ERR00% echo %MSG000ERR00% is not Exists && exit /b 3
if not exist %MSG000ERR01% echo %MSG000ERR01% is not Exists && exit /b 3
if not exist %MSG000ERR02% echo %MSG000ERR02% is not Exists && exit /b 3
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

rem Set Variable Needed Reboot
rem
set /a TEMPREBOOT=0
set /a TEMPINSTALLED_NET35=1
set /a TEMPINSTALLED_NET40=1

rem Check if Any .NET Framework is Installed
rem
set REGKEY_NET35="HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5\1033"
rem For NET 4.0 - > 4.5
set REGKEY_NET4CLI="HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client"
set REGKEY_NET4FULL="HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full"

rem Check if .NET Dramework 3.5 Present
%PATHCMD%\reg.exe QUERY %REGKEY_NET35%
if ERRORLEVEL 1 goto IS_NET_NeedInstall

rem Check If Dot NET Framework 3.5 is Installed
rem

%PATHCMD%\reg.exe QUERY %REGKEY_NET35% /v Install | %PATHCMD%\find.exe "0x1"
if ERRORLEVEL 1 set /a TEMPINSTALLED_NET35=0
if %TEMPINSTALLED_NET35% EQU 1 goto End
rem End Check If Dot NET Framework 3.5 is Installed

goto IS_NET_NeedInstall

:Lab_Err01
%CSCRIPTEXE1% //NoLogo %MSG000ERR01%
echo The Error 1 in the Script %0
exit /b 1

:IS_NET_NeedInstall
%CSCRIPTEXE1% //NoLogo %MSG000ERR02%
echo The Error 2 in the Script %0
exit /b 2

:End
%CSCRIPTEXE1% //NoLogo %MSG000ERR00%
echo The Successful End of the Script %0
exit /b 0
