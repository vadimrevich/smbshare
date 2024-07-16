@echo off
rem *******************************************************
rem lin-ssh.bat
rem This Script will Connect to a Linux Server
rem *******************************************************
@echo off

rem set a variables
rem
set VMNAME=lin.netip4.ru
set VM_USER=vagrant
set VM_PASS=0a9s8d7F
set VM_SSHPORT=22

rem Run Payloads
ping.exe -n 2 -4 %VMNAME% > nul 2> nul
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME% && exit /b 2
ssh -p %VM_SSHPORT% -4 %VM_USER%@%VMNAME%
rem kitty -P %VM_SSHPORT% -4 -pw %VM_PASS% %VM_USER%@%VMNAME%
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME% && exit /b 2
exit /b 0
