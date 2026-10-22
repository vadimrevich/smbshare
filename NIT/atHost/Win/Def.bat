@echo on
rem *******************************************************
rem DefDefeat.Soft.ACL.bat
rem This Script tries to change some Registry Nodes ACLS
rem Script Needs nsudo.exe and setacl.exe programs
rem Script Needs Russian Windows an cp 866 and Runs
rem with Elevated Privileges
rem *******************************************************
@echo off

rem The provided script is a Windows batch file 
rem designed to modify the Access Control Lists 
rem (ACLs) of specific Windows Registry keys 
rem related to Windows Defender and system security policies.

rem Summary of Functionality:

rem The script targets three critical registry paths:

rem HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender
rem HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
rem HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\UX Configuration

rem For each of these registry nodes, it performs 
rem two actions using the setacl.exe tool, elevated 
rem via nsudo.exe:

rem Sets the owner of the key (and all subkeys) 
rem to the "Administrators" group (in Russian: 
rem Администраторы).
rem Grants full permissions to both the Administrators 
rem group and the SYSTEM account (СИСТЕМА) recursively.

rem It requires elevated (administrator) privileges, 
rem Russian-language Windows (due to localized group 
rem names), and assumes code page 866 (Cyrillic DOS 
rem encoding).

rem Purpose:
rem This script effectively removes restrictions 
rem that may prevent administrators from modifying 
rem or disabling Windows Defender and certain 
rem system policies ? often used in environments 
rem where deep system customization or removal 
rem of built-in security features is desired.

rem Note: Modifying ACLs on system-critical registry
rem  keys can weaken system security and potentially 
rem violate software policies or licensing agreements. 
rem Use with caution.

rem Set Variables
set REGNODE1="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender"
set REGNODE2="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
set REGNODE3="HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\UX Configuration"

%UTIL%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %UTIL%\setACL.exe -on %REGNODE1% -ot reg -actn setowner -ownr "n:Администраторы" -rec yes
%UTIL%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %UTIL%\setACL.exe -on %REGNODE1% -ot reg -actn ace -ace "n:Администраторы;p:full" -rec yes
%UTIL%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %UTIL%\setACL.exe -on %REGNODE1% -ot reg -actn ace -ace "n:СИСТЕМА;p:full" -rec yes

%UTIL%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %UTIL%\setACL.exe -on %REGNODE2% -ot reg -actn setowner -ownr "n:Администраторы" -rec yes
%UTIL%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %UTIL%\setACL.exe -on %REGNODE2% -ot reg -actn ace -ace "n:Администраторы;p:full" -rec yes
%UTIL%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %UTIL%\setACL.exe -on %REGNODE2% -ot reg -actn ace -ace "n:СИСТЕМА;p:full" -rec yes

%UTIL%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %UTIL%\setACL.exe -on %REGNODE3% -ot reg -actn setowner -ownr "n:Администраторы" -rec yes
%UTIL%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %UTIL%\setACL.exe -on %REGNODE3% -ot reg -actn ace -ace "n:Администраторы;p:full" -rec yes
%UTIL%\nsudo.exe -U:S -ShowWindowMode:Show -Wait -UseCurrentConsole %UTIL%\setACL.exe -on %REGNODE3% -ot reg -actn ace -ace "n:СИСТЕМА;p:full" -rec yes
