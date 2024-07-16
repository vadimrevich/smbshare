@echo on
@echo off
set FARHOME="C:\Program Files\Far Manager"
set FARHOME=%FARHOME:~1,-1%
%UTIL%\ele.exe "%FARHOME%\far.exe" %*
