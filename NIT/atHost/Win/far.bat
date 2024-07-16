@echo on
@echo off
set FARHOME="C:\Program Files\Far Manager"
set FARHOME=%FARHOME:~1,-1%
"%FARHOME%\far.exe" %*
