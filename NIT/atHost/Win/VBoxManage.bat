@echo on
rem *******************************************************
rem VBoxManage.bat
rem This Script Call VBoxManage.exe for Oracle
rem VirtualBox CLI Manager
rem *******************************************************
@echo off

rem Set Variables
rem
set VBoxManageEXE="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
set CMDLINE=%*

rem Run Payload
%VBoxManageEXE% %CMDLINE%
