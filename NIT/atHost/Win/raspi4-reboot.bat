@echo on
rem *******************************************************
rem server-shutdown
rem This Script will Shutdown a server-home Server
rem with help of Command Line
rem *******************************************************
@echo off

rem Set Path
set pathCMD=%SystemRoot%\System32
set KLINKEXE=%chocolateyinstall%\bin\klink.exe
set PINGEXE=%pathCMD%\ping.exe
set PSPINGEXE=%chocolateyinstall%\bin\psping.exe
set FINDEXE=%pathCMD%\find.exe
set ELEEXE=%UTIL%\ele.exe

rem Set a Computer
set ACOMPUTER=raspberrypi4.yudenisov.internal

set APORT=22
set AUSER=vagrant
set APASS=0a9s8d7F

rem Check Integrity...
rem
if not exist %KLINKEXE% echo %KLINKEXE% is not found && exit /b 1
if not exist %PINGEXE% echo %PINGEXE% is not found && exit /b 1
if not exist %FINDEXE% echo %FINDEXE% is not found && exit /b 1

%PINGEXE% -n 2 %ACOMPUTER% > nul 2>nul
if %errorlevel% neq 0 echo %ACOMPUTER% is not Found && exit /b 1

%PSPINGEXE% -n 1 %ACOMPUTER%:%APORT% | find "(0%% loss" > nul 2> nul
if %ERRORLEVEL% == 0 goto openedAPort
:closedAPort
echo Port %APORT% is not Valid
exit /b 1
:openedAPort

rem Run Payload
%ELEEXE% %KLINKEXE% -P %APORT% -pw %APASS% %AUSER%@%ACOMPUTER% "sudo reboot"

