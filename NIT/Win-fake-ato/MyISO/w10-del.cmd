@echo on
rem *******************************************************
rem w2k22-del.cmd
rem Deactivation of a Microsoft Windows 10+ 
rem Operation Systems (Server and Clients)
rem
rem Please Restart Computer after Script Running
rem *******************************************************
@echo off

rem Set a Variables
set aServer=microsoft.com
rem A Microsoft Windows Server 2022 Datacenter RUS KMS Activation Key
set aWinKey=WX4NM-KYWYW-QJJR4-XV3QB-6VM33

rem Set a Files
rem
set CSCRIPTEXE=%SystemRoot%\System32\cscript.exe
set SLMGRVBS=%SystemRoot%\System32\slmgr.vbs

rem Check Integrity
rem
if not exist %CSCRIPTEXE% echo %CSCRIPTEXE% is not found && exit /b 1
if not exist %SLMGRVBS% echo %SLMGRVBS% is not found && exit /b 1

rem Pun Payloads
rem Delete Activation key and Clear Activation Period

%CSCRIPTEXE% //NoLogo %SLMGRVBS% /dli
rem %CSCRIPTEXE% //NoLogo %SLMGRVBS% /ipk %aWinKey%
%CSCRIPTEXE% //NoLogo %SLMGRVBS% /skms %aServer%
%CSCRIPTEXE% //NoLogo %SLMGRVBS% /upk
%CSCRIPTEXE% //NoLogo %SLMGRVBS% /cpky
%CSCRIPTEXE% //NoLogo %SLMGRVBS% /rearm
%CSCRIPTEXE% //NoLogo %SLMGRVBS% /dli

echo The End of the Script %0
exit /b 0
