@echo off
rem *******************************************************
rem cd.vagrant.term.cmd
rem This Command File Opens an vagrant
rem directory at Explorer and Terminal
rem file for Load a platform-independent adjustments
rem *******************************************************
@echo off

rem Set the Variables...
rem
set CMDFOLDER=D:\yuden\Backup\Laptop\C\Users\vagrant

echo Check Integrity...
rem
if not exist %CMDFOLDER% echo %CMDFOLDER% is not Found && exit /b 1

echo Run Payload...
rem
cd /d %CMDFOLDER%

:End
rem echo The End of the Script %0
exit /b 0