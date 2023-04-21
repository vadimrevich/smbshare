@echo on
rem *******************************************************
rem Test008.ChocoPack.bat
rem Test if Chocolatey Packets are Installed
rem
rem PARAMETERS:	none
rem RETURNS:	0 if Chocolatey Packets are Installed
rem		1 if Check Integrity Error
rem		2 if Packets are not Installed
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
set MSG000ERR00=%~dp0Msg008.ChocoPack.Err00.wsf
set MSG000ERR02=%~dp0Msg008.ChocoPack.Err02.wsf
set MSG000ERR02_01=%~dp0Msg008.ChocoPack.Err02_01.wsf
set MSG000ERR02_02=%~dp0Msg008.ChocoPack.Err02_02.wsf
set MSG000ERR02_03=%~dp0Msg008.ChocoPack.Err02_03.wsf
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

:EndSysFilesCheck
echo End System Files Check!

echo Download and Execute Payloads...
rem

rem Set Directories...
rem
set UTIL=c:\Util
set NITSYS=C:\NIT.SYSUPDATE
set PUB1=C:\pub1
set chocolatey=C:\ProgramData\chocolatey

rem Set Registry Node..

rem Set Executed Files...


echo Check Directories...
rem
if not exist %UTIL% echo UTIL is not found && goto Lab_Err01
if not exist %NITSYS% echo NITSYS is not found && goto Lab_Err01
if not exist %PUB1% echo PUB1 is not found && goto Lab_Err01

echo Check if Chocolatey Installed...
rem
if not exist %chocolatey% echo chocolatey is not found && goto Lab_Err02_01

echo Check Necessary Packets...
rem
if not exist %chocolatey%\lib\chocolatey-compatibility.extension echo chocolatey\chocolatey-compatibility.extension is not found && goto Lab_Err02_02
if not exist %chocolatey%\lib\chocolatey-core.extension echo chocolatey\chocolatey-core.extension is not found && goto Lab_Err02_02
if not exist %chocolatey%\lib\chocolatey-windowsupdate.extension echo chocolatey\chocolatey-windowsupdate.extension is not found && goto Lab_Err02_02
if not exist %chocolatey%\lib\PowerShell echo chocolatey\PowerShell is not found && goto Lab_Err02_02
if not exist %chocolatey%\lib\chocolatey-dotnetfx.extension echo chocolatey\chocolatey-dotnetfx.extension is not found && goto Lab_Err02_02
if not exist %chocolatey%\lib\vcredist-all echo chocolatey\vcredist-all is not found && goto Lab_Err02_02
if not exist %chocolatey%\lib\BoxStarter.Common echo chocolatey\BoxStarter.Common is not found && goto Lab_Err02_02
if not exist %chocolatey%\lib\boxstarter echo chocolatey\boxstarter is not found && goto Lab_Err02_02

echo Check if Cocolatey Packets Pack 01 is installed...
rem
if not exist %chocolatey%\lib\exponenta.main.files echo chocolatey\exponenta.main.files is not found && goto Lab_Err02_03
if not exist %chocolatey%\lib\elevation.nit echo chocolatey\elevation.nit is not found && goto Lab_Err02_03
if not exist %chocolatey%\lib\hidden.start.nit.main echo chocolatey\hidden.start.nit.main is not found && goto Lab_Err02_03
if not exist %chocolatey%\lib\sysinternals echo chocolatey\sysinternals is not found && goto Lab_Err02_03
if not exist %chocolatey%\lib\7zip.install echo chocolatey\7zip.install is not found && goto Lab_Err02_03
if not exist %chocolatey%\lib\7zip.portable echo chocolatey\7zip.portable is not found && goto Lab_Err02_03
if not exist %chocolatey%\lib\7zip echo chocolatey\7zip is not found && goto Lab_Err02_03
if not exist %chocolatey%\lib\unxUtils echo chocolatey\unxUtils is not found && goto Lab_Err02_03
if not exist %chocolatey%\lib\Wget echo chocolatey\Wget is not found && goto Lab_Err02_03
if not exist %chocolatey%\lib\curl echo chocolatey\curl is not found && goto Lab_Err02_03
if not exist %chocolatey%\lib\adminset01.nit echo chocolatey\adminset01.nit is not found && goto Lab_Err02_03


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
