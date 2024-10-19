@echo off
rem *******************************************************
rem lin-ssh.bat
rem This Script will Connect to a Linux Server
rem *******************************************************
@echo off

rem set a variables
rem
set VMNAME=diana-laptop.yudenisov.internal
set VM_USER=yuden
set VM_PASS=P@ssp0rtSaratov
set VM_SSHPORT=22

rem Run Payloads
ping.exe -n 2 -4 %VMNAME% > nul 2> nul
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME% && exit /b 2
rem ssh -p %VM_SSHPORT% -4 %VM_USER%@%VMNAME%
kitty -P %VM_SSHPORT% -4 -pw %VM_PASS% %VM_USER%@%VMNAME%
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME% && exit /b 2
exit /b 0
