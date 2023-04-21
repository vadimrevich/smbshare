@echo on
rem *******************************************************
rem TestAll.AdminPack.bat
rem Test if Files of AdminPack Packet are Present
rem
rem PARAMETERS:	none
rem RETURNS:	0 if AdminPack Files are Present
rem		1 if Check Integrity Error
rem		2 if AdminPack Files are not Present
rem		3 if AdminPack Files are not Present
rem     17 if Runs without Elevated Privileges
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=AdminPack
set PRODUCT_NAME_FOLDER=
set FIRM=NIT
set SMBSHARE0=%~dp0..\..

echo Check OS Version and Processor Architecture...
rem
rem Set OS Architecture
Set xOS=x64& If "%PROCESSOR_ARCHITECTURE%"=="x86" If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x86

set OS_ARCH=%xOS%

rem Set Messages Files
rem
set MSG000ERR01=%~dp0Msg000.CheckIntegrity.Err01.wsf
set MSG000ERR00=%~dp0Msg000.CheckIntegrity.Err00.wsf
set MSG000ERR02=%~dp0MsgAll.AdminPack.Err02.wsf
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
if not exist C:\Windows echo "C:\Windows not Exists" && goto Lab_Err02
if not exist "%TEMP%" echo "TEMP not Exists" && goto Lab_Err02
if not exist "%ALLUSERSPROFILE%" echo "ALLUSERSPROFILE not Exists" && goto Lab_Err02
if not exist "%SystemRoot%" echo "SystemRoot not Exists" && goto Lab_Err02
if not exist "%PATHCMD%" echo "PATHCMD not Exists" && goto Lab_Err02
if not exist "%PATHCMD%\wbem" echo "%PATHCMD%\wbem not Exists" && goto Lab_Err02
if not exist "%PATHCMD%\WindowsPowerShell\v1.0" echo "%PATHCMD%\WindowsPowerShell\v1.0 not Exists" && goto Lab_Err02
if %OS_ARCH%==x86 goto EndFolderCheck
if not exist "%PATHCMDWOW%" echo "PATHCMDWOW not Exists" && goto Lab_Err02
if not exist "%PATHCMDWOW%\wbem" echo "%PATHCMDWOW%\wbem not Exists" && goto Lab_Err02
if not exist "%PATHCMDWOW%\WindowsPowerShell\v1.0" echo "%PATHCMDWOW%\WindowsPowerShell\v1.0 not Exists" && goto Lab_Err02

:EndFolderCheck
echo End System Folder Check

rem Check if System File Present at FileSystem
echo check if System File Present...

if not exist "%COMSPEC%" echo "COMSPEC not Exists" && goto Lab_Err02
if not exist "%PATHCMD%\cmd.exe" echo "%PATHCMD%\cmd.exe not Exists" && goto Lab_Err02
if not exist "%PATHCMD%\reg.exe" echo "%PATHCMD%\reg.exe not Exists" && goto Lab_Err02
if not exist "%PATHCMD%\attrib.exe" echo "%PATHCMD%\attrib.exe not Exists" && goto Lab_Err02
if not exist "%PATHCMD%\cscript.exe" echo "%PATHCMD%\cscript.exe not Exists" && goto Lab_Err02
if not exist "%PATHCMD%\wscript.exe" echo "%PATHCMD%\wscript.exe not Exists" && goto Lab_Err02
if not exist "%PATHCMD%\shutdown.exe" echo "%PATHCMD%\shutdown.exe not Exists" && goto Lab_Err02
if not exist "%PATHCMD%\find.exe" echo "%PATHCMD%\find.exe not Exists" && goto Lab_Err02
if not exist "%PATHCMD%\wbem\WMIC.exe" echo "%PATHCMD%\wbem\WMIC.exe not Exists" && goto Lab_Err02
rem if not exist "%PATHCMD%\bitsadmin.exe" echo "%PATHCMD%\bitsadmin.exe not Exists" && goto Lab_Err02
if not exist "%PATHCMD%\WindowsPowerShell\v1.0\powershell.exe" echo "%PATHCMD%\WindowsPowerShell\v1.0\powershell.exe not Exists" && goto Lab_Err02
if %OS_ARCH%==x86 goto EndSysFilesCheck
if not exist "%PATHCMDWOW%\cmd.exe" echo "%PATHCMDWOW%\cmd.exe not Exists" && goto Lab_Err02
if not exist "%PATHCMDWOW%\cscript.exe" echo "%PATHCMDWOW%\cscript.exe not Exists" && goto Lab_Err02
if not exist "%PATHCMDWOW%\wscript.exe" echo "%PATHCMDWOW%\wscript.exe not Exists" && goto Lab_Err02
if not exist "%PATHCMDWOW%\wbem\WMIC.exe" echo "%PATHCMDWOW%\wbem\WMIC.exe not Exists" && goto Lab_Err02
if not exist "%PATHCMDWOW%\WindowsPowerShell\v1.0\powershell.exe" echo "%PATHCMDWOW%\WindowsPowerShell\v1.0\powershell.exe not Exists" && goto Lab_Err02

:EndSysFilesCheck
echo End System Files Check!

rem
rem Set Directories Path
set MSFTPROD_DIR0=%~dp0

rem Set Files and Paths...
rem
set AMSFTFILE01=%MSFTPROD_DIR0%\Test001.dotNet3.bat
set AMSFTFILE02=%MSFTPROD_DIR0%\Test002.dotNet4.bat
set AMSFTFILE03=%MSFTPROD_DIR0%\Test003.InstDir.bat
set AMSFTFILE05=%MSFTPROD_DIR0%\Test005.DownFiles.bat
set AMSFTFILE06=%MSFTPROD_DIR0%\Test006.Libs.bat
set AMSFTFILE07=%MSFTPROD_DIR0%\Test007.WinComp01.bat
set AMSFTFILE08=%MSFTPROD_DIR0%\Test008.ChocoPack.bat
set AMSFTFILE09=%MSFTPROD_DIR0%\Test009.Monitoring.bat
rem

rem Set Integrity...
rem
if not exist %AMSFTFILE01% echo "%AMSFTFILE01% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE02% echo "%AMSFTFILE02% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE03% echo "%AMSFTFILE03% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE05% echo "%AMSFTFILE05% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE06% echo "%AMSFTFILE06% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE07% echo "%AMSFTFILE07% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE08% echo "%AMSFTFILE08% not Exist" && goto Lab_Err02
if not exist %AMSFTFILE09% echo "%AMSFTFILE09% not Exist" && goto Lab_Err02

echo The End Checking Integrity

rem
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

call %AMSFTFILE01%
if errorlevel==1 goto Lab_Err02

call %AMSFTFILE02%
if errorlevel==1 goto Lab_Err02

call %AMSFTFILE03%
if errorlevel==1 goto Lab_Err02

call %AMSFTFILE05%
if errorlevel==1 goto Lab_Err02

call %AMSFTFILE06%
if errorlevel==1 goto Lab_Err02

call %AMSFTFILE07%
if errorlevel==1 goto Lab_Err02

call %AMSFTFILE08%
if errorlevel==1 goto Lab_Err02

call %AMSFTFILE09%
if errorlevel==1 goto Lab_Err02

echo End Run Payloads...
rem
goto End

:Lab_Err02
%CSCRIPTEXE1% //NoLogo %MSG000ERR02%
echo The Error 2 in the Script %0
exit /b 2

:End
%CSCRIPTEXE1% //NoLogo %MSG000ERR00%
echo The Successful End of the Script %0
exit /b 0