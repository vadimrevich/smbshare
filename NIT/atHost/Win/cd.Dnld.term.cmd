@echo off
rem *******************************************************
rem cd.UserPr.term.cmd
rem This Command File Opens a UserProfile
rem directory at Explorer and Terminal
rem file for Load a platform-independent adjustments
rem *******************************************************
@echo off

rem Set the Variables...
rem
FOR /f "tokens=3" %%Z in ('Reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{374DE290-123F-4565-9164-39C4925E467B}" ^|findstr /i "REG_"') do SET Downloads=%%Z

set CMDFOLDER=%Downloads%

echo Check Integrity...
rem
if not exist %CMDFOLDER% echo %CMDFOLDER% is not Found && exit /b 1

echo Run Payload...
rem
cd /d %CMDFOLDER%

:End
rem echo The End of the Script %0
exit /b 0