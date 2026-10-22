@echo off
rem *******************************************************
rem SManager.bat
rem Run Windows Server Manager
rem *******************************************************

rem Set a variable

set aProg=%windir%\system32\ServerManager.exe

rem Check Integrity
rem
if not exist %aProg% echo File %aProg% is not Found && exit /b 1

rem Run Payload
rem
start %aProg%

:End
@echo The End of the Script %0
exit /b 0
