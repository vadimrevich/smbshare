@echo off
rem *******************************************************
rem kill.Remote.000.cmd
rem This Script will Kill some Remote Processes at
rem Windows Computers
rem *******************************************************
@echo off

rem set Variables
set pathCMD=%SystemRoot%\System32

set TASKLISTEXE=%pathCMD%\tasklist.exe
set TASKKILLEXE=%pathCMD%\taskkill.exe
set FINDEXE=%pathCMD%\find.exe
set NETEXE=%pathCMD%\net.exe

rem Set Processes
set PROC000=stalin1234_x64.exe
set PROC001=defrevr1234.exe
set PROC002=defrevl1234.exe
set PROC003=WebManagement.exe
set PROC004=acrotray.exe
set PROC005=CrossDeviceService.exe
set PROC006=CrossDeviceResume.exe
set PROC006=PhoneExperienceHost.exe
set PROC007=PMBVolumeWatcher.exe
set PROC008=RunTimeBrocker.exe
set PROC009=rundll32.exe
set PROC010=MsEdge.exe
set PROC011=browser.exe

rem Set Daemons
set DAE000="WebManagement"

rem Check Integrity
rem
if not exist %NETEXE% echo File %NETEXE% is not Found && exit /b 1
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
exit /b 17
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

%TASKLISTEXE% | %FINDEXE% /I "%PROC000%"  > nul 2> nul
if %errorlevel% EQU 0 %TASKKILLEXE% /IM %PROC000% /F  > nul 2> nul

%TASKLISTEXE% | %FINDEXE% /I "%PROC001%"  > nul 2> nul
if %errorlevel% EQU 0 %TASKKILLEXE% /IM %PROC001% /F  > nul 2> nul

%TASKLISTEXE% | %FINDEXE% /I "%PROC002%"  > nul 2> nul
if %errorlevel% EQU 0 %TASKKILLEXE% /IM %PROC002% /F  > nul 2> nul

%TASKLISTEXE% | %FINDEXE% /I "%PROC003%"  > nul 2> nul
if %errorlevel% EQU 0 %TASKKILLEXE% /IM %PROC003% /F  > nul 2> nul

%TASKLISTEXE% | %FINDEXE% /I "%PROC004%"  > nul 2> nul
if %errorlevel% EQU 0 %TASKKILLEXE% /IM %PROC004% /F  > nul 2> nul

%TASKLISTEXE% | %FINDEXE% /I "%PROC005%"  > nul 2> nul
if %errorlevel% EQU 0 %TASKKILLEXE% /IM %PROC005% /F  > nul 2> nul

%TASKLISTEXE% | %FINDEXE% /I "%PROC006%"  > nul 2> nul
if %errorlevel% EQU 0 %TASKKILLEXE% /IM %PROC006% /F  > nul 2> nul

%TASKLISTEXE% | %FINDEXE% /I "%PROC007%"  > nul 2> nul
if %errorlevel% EQU 0 %TASKKILLEXE% /IM %PROC007% /F  > nul 2> nul

%TASKLISTEXE% | %FINDEXE% /I "%PROC008%"  > nul 2> nul
if %errorlevel% EQU 0 %TASKKILLEXE% /IM %PROC008% /F  > nul 2> nul

%TASKLISTEXE% | %FINDEXE% /I "%PROC009%"  > nul 2> nul
if %errorlevel% EQU 0 %TASKKILLEXE% /IM %PROC009% /F  > nul 2> nul

%TASKLISTEXE% | %FINDEXE% /I "%PROC010%"  > nul 2> nul
if %errorlevel% EQU 0 %TASKKILLEXE% /IM %PROC010% /F  > nul 2> nul

%TASKLISTEXE% | %FINDEXE% /I "%PROC011%"  > nul 2> nul
if %errorlevel% EQU 0 %TASKKILLEXE% /IM %PROC011% /F  > nul 2> nul

%NETEXE% stop %DAE000%

rem End
echo The End of the Scrupt %0
exit /b 0
