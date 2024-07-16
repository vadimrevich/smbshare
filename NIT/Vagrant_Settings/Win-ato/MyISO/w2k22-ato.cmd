@echo on
rem *******************************************************
rem w2k22-ato.cmd
rem Activation of a Windows Server 2022 Datacenter Rus
rem *******************************************************
@echo off

rem Set a Variables
set aServer=lin.netip4.ru
set aWinKey=WX4NM-KYWYW-QJJR4-XV3QB-6VM33

rem Set a Files
rem
set CSCRIPTEXE=%SystemRoot%\System32\cscript.exe
set SLMGRVBS=%SystemRoot%\System32\slmgr.vbs

rem Check Integrity
rem
if not exist %CSCRIPTEXE% echo %CSCRIPTEXE% is not found && exit /b 1
if not exist %SLMGRVBS% echo %SLMGRVBS% is not found && exit /b 1

%CSCRIPTEXE% //NoLogo %SLMGRVBS% /dli
%CSCRIPTEXE% //NoLogo %SLMGRVBS% /ipk %aWinKey%
%CSCRIPTEXE% //NoLogo %SLMGRVBS% /skms %aServer%
%CSCRIPTEXE% //NoLogo %SLMGRVBS% /ato
%CSCRIPTEXE% //NoLogo %SLMGRVBS% /dli

echo The End of the Script %0
exit /b 0
