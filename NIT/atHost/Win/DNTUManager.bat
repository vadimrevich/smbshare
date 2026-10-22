@echo off
rem *******************************************************
rem DNTUManager.bat
rem Run Dameware Remote Support Manager
rem *******************************************************

rem Set a variable

set aProg="C:\Program Files (x86)\SolarWinds\DameWare Remote Support\DNTU.exe"

rem Check Integrity
rem
if not exist %aProg% echo File %aProg% is not Found && exit /b 1

rem Run Payload
rem
start /I /B %COMSPEC% /c %aProg%

:End
@echo The End of the Script %0
exit /b 0
