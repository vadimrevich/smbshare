@echo on
rem *******************************************************
rem server-shutdown
rem This Script will Shutdown a server-home Server
rem with help of Command Line
rem *******************************************************
@echo off

rem Set Path
set pathCMD=%SystemRoot%\System32
set SHUTDOWNEXE=%pathCMD%\shutdown.exe
set ELEEXE=%UTIL%\ele.exe

rem Set a Computer
set ACOMPUTER=SERVER-HOME.yudenisov.internal

rem Run Payload
%ELEEXE% %SHUTDOWNEXE% /m \\%ACOMPUTER% /r /t 00
