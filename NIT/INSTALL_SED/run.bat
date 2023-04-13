@echo on
rem *******************************************************
rem install_sed.bat
rem This Script Install sed.exe File via Chocolatey and
rem add System dll Libraries at SysWOW Directory
rem PARAMETERS:	NONE
rem RETURNS:	0 if Success Run
rem		16 if Check Integrity Error
rem		17 if not Elevated Privileges Run
rem *******************************************************
@echo off

setlocal enableextensions enabledelayedexpansion

rem Metadata

set PRODUCT_NAME=INSTALL_SED
SET FIRM_NAME=NIT

echo Set Environments Settings...
rem
set SYSTarget=%SystemRoot%\SysWOW64
set ChockPath=%ChocolateyInstall%\bin
set UTIL=C:\Util

echo Set Programs...
set CURLEXE=%UTIL%\curl.exe

if exist %SYSTarget% goto CheckIntegrity
echo %SYSTarget% not Found
set SYSTarget=%SystemRoot%\System32
goto CheckIntegrity

:CheckIntegrity
echo Check Integrity...
rem
if not exist %SYSTarget% echo %SYSTarget% not found && exit /b 16
if not exist %ChockPath%\cinst.exe echo %ChockPath%\sed.exe not found && exit /b 16
if not exist %CURLEXE% echo %CURLEXE% not found && exit /b 16

rem set Remote Folders
rem
set http_BaseDir01=/PROGS/
set http_ProgDir01=%http_BaseDir01%%FIRM_NAME%/%PRODUCT_NAME%/
set REG_FOLD=/Exponenta/Distrib/LIB/LIB-REG/
set CMD_FOLD=/Exponenta/Distrib/LIB-CMD/
set EXE_FOLD=/Exponenta/Distrib/LIB-EXE/
rem Set Hosts
rem
set http_pref01=http
set http_host01=file.netip4.ru
set http_port01=80
rem
echo Set Hosts...
rem
set host01=%http_pref01%://%http_host01%:%http_port01%%http_ProgDir01%

title Installing Packages 
::-------------------------------------
REM  --> CheckING for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
rem Lock Data
exit /b 17
rem
set getadminvbs=nit-sedinstall.vbs
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\%getadminvbs%"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\%getadminvbs%"

    %SystemRoot%\system32\wscript.exe "%temp%\%getadminvbs%"
    del "%temp%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

echo Delete Old DLLs
rem
if exist %SYSTarget%\libiconv-2.dll del /Q /F %SYSTarget%\libiconv-2.dll
if exist %SYSTarget%\libiconv2.dll del /Q /F %SYSTarget%\libiconv2.dll
if exist %SYSTarget%\libintl3.dll del /Q /F %SYSTarget%\libintl3.dll
if exist %SYSTarget%\regex2.dll del /Q /F %SYSTarget%\regex2.dll
rem goto End

echo Download Libs...
rem
%CURLEXE% %host01%libiconv-2.dll -o %~dp0libiconv-2.dll
%CURLEXE% %host01%libiconv2.dll -o %~dp0libiconv2.dll
%CURLEXE% %host01%libintl3.dll -o %~dp0libintl3.dll
%CURLEXE% %host01%regex2.dll -o %~dp0regex2.dll

echo Install sed.exe...
rem
%ChockPath%\cinst.exe -y sed
if not exist %ChockPath%\sed.exe echo %ChockPath%\sed.exe not found && exit /b 16
echo Copy System Files...
rem
move %~dp0libiconv-2.dll %SYSTarget%\libiconv-2.dll
move %~dp0libiconv2.dll %SYSTarget%\libiconv2.dll
move %~dp0libintl3.dll %SYSTarget%\libintl3.dll
move %~dp0regex2.dll %SYSTarget%\regex2.dll

:End
echo The Success End of the Script %0
exit /b 0
