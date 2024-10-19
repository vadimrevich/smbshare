rem *******************************************************
rem hstart.run.opt-bat.cmd
rem *******************************************************
@echo off
rem Set Variables

set HSTARTPATH="C:\Program Files\Hidden Start\hstart64.exe"
set aFILE=%~dp0ftpuse.files.mount.cmd
rem ### set aFILE=%1

set CURDIR=%CD%

rem Run payloads
rem
echo on
%HSTARTPATH% /NOCONSOLE /RUNAS /NOUAC /SHELL %aFile%
cd/d %CURDIR%

