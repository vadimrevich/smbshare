@echo on
rem *******************************************************
rem sch_run-create.cmd
rem This Command File will Create a Schedule
rem Task for Run a Run Dialog Box
rem *******************************************************
@echo off

rem Set a Variable

set SCHNAME=SCH_Run
set SCHTASKEXE=%SystemRoot%\System32\schtasks.exe
set aStartingCmd="%SystemRoot%\SysWOW64\rundll32.exe shell32.dll,#61"
set aStartingCmd=%aStartingCmd:"=%
set aFullCmd="%COMSPEC% /c start %aStartingCmd%"

rem Run payload
%SCHTASKEXE% /Create /RL Highest /TN %SCHNAME% /SC ONCE /ST 14:00 /TR %aFullCmd%

