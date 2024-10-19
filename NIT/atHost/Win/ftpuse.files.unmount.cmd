rem *******************************************************
rem ftpuse-files.mount.cmd
rem *******************************************************
echo off
rem Set Variables

set HSTARTPATH="C:\Program Files\Hidden Start\hstart64.exe"

set NETDISK=Y:
set aDomain=files.netip4.ru
set aUSER=mssqlsr
set aPASS=Admin01234
set aPORT=21
set aREMPATH=/
set aPATH="C:\Program Files\Ferro Software\FtpUse"
set aPATH=%aPATH:"=%
rem set CYGFUSE=WinFsp;
rem set PATH=%PATH%;%aPath%
set CURDIR=%CD%

rem Run payloads
rem
echo on
rem cd /d "%aPATH%"
rem "%aPATH%\ftpuse.exe" %NETDISK% %aDomain% %aPASS% /USER:%aUSER% /PORT:%aPORT% /DEBUG /HIDE
"%aPATH%\ftpuse.exe" %NETDISK% /Delete
rem cd/d %CURDIR%

