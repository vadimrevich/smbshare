@echo on
rem *******************************************************
rem sch_run.cmd
rem This Command File will Run a SCH_Run Schedule
rem Task
rem *******************************************************
@echo off

rem Set a Variable

set SCHNAME=SCH_Run
set SCHTASKEXE=%SystemRoot%\System32\schtasks.exe

rem Run payload
%SCHTASKEXE% /RUN /tn %SCHNAME%


