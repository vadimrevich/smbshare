@echo off
rem *******************************************************
rem keenetic-giga-ssh.bat
rem This Script will Connect to a Virtual Machine 
rem *******************************************************
@echo off

rem set a variables
rem
set VMNAME=keenetic-giga.yudenisov.internal
set VM_USER=admin
set VM_PASS=0a9s8d7F
set VM_SSHPORT=55022

rem Run Payloads
ping.exe -n 2 -6 %VMNAME% > nul 2> nul
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME% && exit /b 2
ssh -p %VM_SSHPORT% -6 %VM_USER%@%VMNAME%
rem kitty -P %VM_SSHPORT% -pw %VM_PASS% -6 %VM_USER%@%VMNAME%
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME% && exit /b 2
exit /b 0
