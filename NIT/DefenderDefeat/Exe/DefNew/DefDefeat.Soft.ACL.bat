@echo on
rem *******************************************************
rem DefDefeat.Soft.ACL.bat
rem This Script tries to change some Registry Nodes ACLS
rem Script Needs nsudo.exe and setacl.exe programs
rem Script Needs Russian Windows an cp 866 and Runs
rem with Elevated Privileges
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=DefenderDefeat
SET FIRM_NAME=NIT

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

rem Set Variables
set REGNODE1="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender"
set REGNODE2="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
set REGNODE3="HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\UX Configuration"

rem Set Directories
set LocalPath=%PRODPROFILE%

%LocalPath%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %LocalPath%\setACL.exe -on %REGNODE1% -ot reg -actn setowner -ownr "n:Администраторы" -rec yes
%LocalPath%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %LocalPath%\setACL.exe -on %REGNODE1% -ot reg -actn ace -ace "n:Администраторы;p:full" -rec yes
%LocalPath%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %LocalPath%\setACL.exe -on %REGNODE1% -ot reg -actn ace -ace "n:СИСТЕМА;p:full" -rec yes

%LocalPath%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %LocalPath%\setACL.exe -on %REGNODE2% -ot reg -actn setowner -ownr "n:Администраторы" -rec yes
%LocalPath%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %LocalPath%\setACL.exe -on %REGNODE2% -ot reg -actn ace -ace "n:Администраторы;p:full" -rec yes
%LocalPath%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %LocalPath%\setACL.exe -on %REGNODE2% -ot reg -actn ace -ace "n:СИСТЕМА;p:full" -rec yes

%LocalPath%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %LocalPath%\setACL.exe -on %REGNODE3% -ot reg -actn setowner -ownr "n:Администраторы" -rec yes
%LocalPath%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %LocalPath%\setACL.exe -on %REGNODE3% -ot reg -actn ace -ace "n:Администраторы;p:full" -rec yes
%LocalPath%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %LocalPath%\setACL.exe -on %REGNODE3% -ot reg -actn ace -ace "n:СИСТЕМА;p:full" -rec yes
