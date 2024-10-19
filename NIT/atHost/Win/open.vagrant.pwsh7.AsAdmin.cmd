@echo on
rem *******************************************************
rem open.vagrant.term.AsAdmin.cmd
rem This Command File Opens an vagrant
rem directory at Explorer and Terminal
rem file for Load a platform-independent adjustments
rem *******************************************************
@echo off

rem Set the Variables...
rem
set CMDFOLDER=D:\yuden\Backup\Laptop\C\Users\vagrant
set CMDFILE01=%CMDFOLDER%\OpenExplorerThisAsAdmin.cmd
set CMDFILE02=%CMDFOLDER%\OpenExplorerThis.cmd
set CMDFILE03=%CMDFOLDER%\OpenTerminalThisAsAdmin.cmd
set CMDFILE04=%CMDFOLDER%\OpenTerminalThis.cmd
set CMDFILE05=%CMDFOLDER%\OpenPosh5ThisAsAdmin.cmd
set CMDFILE06=%CMDFOLDER%\OpenPosh5This.cmd
set CMDFILE07=%CMDFOLDER%\OpenPosh7ThisAsAdmin.cmd
set CMDFILE08=%CMDFOLDER%\OpenPosh7This.cmd

echo Check Integrity...
rem
if not exist %CMDFOLDER% echo %CMDFOLDER% is not Found && exit /b 1

echo Run Payload...
rem
rem call %CMDFILE01%
call %CMDFILE07%

:End
echo The End of the Script %0
exit /b 0