@echo off
rem *******************************************************
rem msys2.bat
rem Run NSYS2-64 Shell at Windows Command Shell
rem *******************************************************
@echo off

rem Set variables

set aPath=C:\tools\msys64\usr\bin

rem Run Payloads

set PATH=;%aPath%;%PATH%
%aPath%\bash.exe --login -i

:End
exit /b 0
