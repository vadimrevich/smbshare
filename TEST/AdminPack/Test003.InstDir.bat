@echo on
rem *******************************************************
rem Test003.InstDir.bat
rem Test if Necessary Directories are Installed
rem
rem PARAMETERS:	none
rem RETURNS:	0 if Directories are Installed
rem		1 if Check Integrity Error
rem		2 if Directories are not Installed
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
set MSG000ERR00=%~dp0Msg003.InstDir.Err00.wsf
set MSG000ERR02=%~dp0Msg003.InstDir.Err02.wsf
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

echo Download and Execute Payloads...
rem

rem Set Directories...
rem
set UTIL=c:\Util
set NITSYS=C:\NIT.SYSUPDATE
set PUB1=C:\pub1
set PUB=C:\pub
set TEMPPUB=%PUB1%\Distrib
set ZLPUB=%PUB1%\Distrib\Zlovred
set UTILPUB=%PUB1%\Util
set inetpub=C:\inetpub
set ip_wwwroot=%inetpub%\wwwroot
set dotbin=C:\.BIN
set CAdir=C:\CA
set ELEVATION=C:\ELEVATION
set NITPROFILE=%ALLUSERSPROFILE%\NIT

echo Check Directories...
rem
if not exist %UTIL% echo UTIL is not found && goto Lab_Err02
if not exist %NITSYS% echo NITSYS is not found && goto Lab_Err02
if not exist %PUB1% echo PUB1 is not found && goto Lab_Err02
rem if not exist %PUB% echo PUB is not found && goto Lab_Err02
if not exist %TEMPPUB% echo TEMPPUB is not found && goto Lab_Err02
if not exist %ZLPUB% echo ZLPUB is not found && goto Lab_Err02
if not exist %UTILPUB% echo UTILPUB is not found && goto Lab_Err02
if not exist %inetpub% echo inetpub is not found && goto Lab_Err02
if not exist %ip_wwwroot% echo ip_wwwroot is not found && goto Lab_Err02
if not exist %CAdir% echo CAdir is not found && goto Lab_Err02
if not exist %ELEVATION% echo ELEVATION is not found && goto Lab_Err02
if not exist %NITPROFILE% echo NITPROFILE is not found && goto Lab_Err02
if not exist %dotbin% echo dotbin is not found && goto Lab_Err02

goto End

:Lab_Err01
%CSCRIPTEXE1% //NoLogo %MSG000ERR01%
echo The Error 1 in the Script %0
exit /b 1

:Lab_Err02
%CSCRIPTEXE1% //NoLogo %MSG000ERR02%
echo The Error 2 in the Script %0
exit /b 2

:End
%CSCRIPTEXE1% //NoLogo %MSG000ERR00%
echo The Successful End of the Script %0
exit /b 0
