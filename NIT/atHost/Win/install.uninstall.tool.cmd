@echo off
rem *******************************************************
rem install.uninstall.tool.cmd
rem This script will download and Install Uninstall Tool
rem Repack on Windows Computer
rem Admin Pack Packets must be Installed, and Active
rem Antivirus Protection Must be Turned Off
rem *******************************************************
@echo off

rem Set a Variables

rem Metadata

set PRODUCT_NAME=Uninstall.Tool
set PRODUCT_NAME_FOLDER=
set FIRM_NAME=Crystalidea
set OS_ARCH=

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set Host
rem
set http_prefix=http
set http_domain=file.netip4.ru
set http_port=80
set http_dir000=/PROGS/%FIRM_NAME%/%PRODUCT_NAME%/Scripts/
set HOST00=%http_prefix%://%http_domain%:%http_port%%http_dir000%

rem Set DownloadShellFolder Variable...
setlocal EnableExtensions DisableDelayedExpansion

set "Reg32=%SystemRoot%\System32\reg.exe"
if not "%ProgramFiles(x86)%" == "" set "Reg32=%SystemRoot%\SysWOW64\reg.exe"

set "DownloadShellFolder="
for /F "skip=1 tokens=1,2*" %%T in ('%Reg32% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "{374DE290-123F-4565-9164-39C4925E467B}" 2^>nul') do (
    if /I "%%T" == "{374DE290-123F-4565-9164-39C4925E467B}" (
        set "DownloadShellFolder=%%V"
        goto GetDownloadDirectory
    )
)

:GetDownloadDirectory
set "DownloadDirectory="
for /F "skip=1 tokens=1,2,3*" %%S in ('%Reg32% query "HKCU\Software\Microsoft\Internet Explorer" /v "Download Directory" 2^>nul') do (
    if /I "%%S" == "Download" (
        if /I "%%T" == "Directory" (
            set "DownloadDirectory=%%V"
            goto GetSaveDirectory
        )
    )
)

:GetSaveDirectory
set "SaveDirectory="
for /F "skip=1 tokens=1,2,3*" %%S in ('%Reg32% query "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Save Directory" 2^>nul') do (
    if /I "%%S" == "Save" (
        if /I "%%T" == "Directory" (
            set "SaveDirectory=%%V"
            goto OutputResults
        )
    )
)

:OutputResults
set Downloads=%DownloadShellFolder%
set UTIL=C:\Util
set CURLEXE=%UTIL%\CURL.EXE
set a7ZAEXE=%UTIL%\7za.exe

rem Set Files

set ARCH000=Uninstall.Tool.7z
set CMD000=INSTALL.cmd

set PASS=szbeck

rem Check Integrity
rem
if not exist %CURLEXE% echo %CURLEXE% is not found && exit /b 1
if not exist %a7ZAEXE% echo %a7ZAEXE% is not found && exit /b 1
if not exist %Downloads% echo %Downloads% is not found && exit /b 1

rem
echo Download and Run Payloads...
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

rem Download and Execute Payloads
rem

rem Create a Directory
if exist %Downloads%\%PRODUCT_NAME% del /Q /S /F %Downloads%\%PRODUCT_NAME%
md %Downloads%\%PRODUCT_NAME%

rem Download and Unpack an %ARCH000%
%CURLEXE% -o %Downloads%\%PRODUCT_NAME%\%ARCH000% %HOST00%%ARCH000%
%a7ZAEXE% x -o%Downloads%\%PRODUCT_NAME% -p%PASS% %Downloads%\%PRODUCT_NAME%\%ARCH000%

rem Run %CMD000%
if not exist %Downloads%\%PRODUCT_NAME%\%CMD000% echo %CMD000% is not found && exit /b 1
call %Downloads%\%PRODUCT_NAME%\%CMD000%

rem The End of the Script
echo The Script %0 is Run with Success
exit /b 0
 
