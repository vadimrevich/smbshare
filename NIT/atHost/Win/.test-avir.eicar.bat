@echo off
rem *******************************************************
rem .test-avir.eicar.bat
rem This Commend File Checks if a Folder has not Exclusions
rem at any Antivirus program and Says it to User
rem
rem In its Work the Command Use an eicar Antivirus Checking
rem File .test-avir.eicar.txt for Detecting Antivirus
rem In its Work the File use timeout command for wait 
rem some Seconds.
rem
rem PARAMETERS:	NONE
rem RETURNS:	0 if all Folders are Present and all of them are at Antivirus Exclusiosns.
rem		1 if all Folders are Present but some Folders are not at Antivirus Exclusions.
rem		2 if some Folders are not present at a Computer System.
rem		3 if System Check Integrity Error
rem		4 if Windows Defender is not Installed
rem		17 a Command File Runs without Elevated Privileges
rem *******************************************************
echo off

rem Set Test file
rem
set TESTFILE=.test-avir.eicar.txt
rem Set Current Directory...
set CURDIR=%~dp0

rem Set Paths...
rem
set pathCMD=%SystemRoot%\System32
rem Set Files...
rem
set NOTEPADEXE=%SystemRoot%\notepad.exe
set TASKKILLEXE=%pathCMD%\taskkill.exe
set MPCMDRUNEXE="%ProgramFiles%\Windows Defender\MpCmdRun.exe"

echo Check System Integrity...
rem
if not exist %NOTEPADEXE% echo %NOTEPADEXE% is not found && exit /b 3
if not exist %TASKKILLEXE% echo %TASKKILLEXE% is not found && exit /b 3
if not exist %MPCMDRUNEXE% echo %MPCMDRUNEXE% is not found && goto Lab_AV_NotInstalled

echo Check Own Integrity...
rem
if not exist %CURDIR%%TESTFILE% echo Integrity Error: a Packet is not Properly Installed && exit /b 3
rem
%MPCMDRUNEXE% -Scan -ScanType 3 -File %CURDIR%%TESTFILE%
rem start %NOTEPADEXE% %CURDIR%%TESTFILE%
rem timeout 10
rem %TASKKILLEXE% /IM notepad.exe /F
rem timeout 10
dir %CURDIR%%TESTFILE% 2>&1 > nul
if errorlevel 1 goto Lab_Own_Integrity

goto End
:Lab_Own_Integrity
timeout 2
exit /b 2

:End
timeout 3
exit /b 0

