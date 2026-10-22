@echo off
rem *******************************************************
rem keen-ssh.bat
rem This Script will Connect to a Virtual Machine 
rem *******************************************************
@echo off

rem set a variables
rem
set VMNAME=KEENETIC-9335.yudenisov.internal
set VM_USER=root
set VM_PASS=0A9s8d7F
set VM_SSHPORT=222

rem Run Payloads
ping.exe -n 2 -4 %VMNAME% > nul 2> nul
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME% Ping Error && exit /b 2
ssh -p %VM_SSHPORT% -4 %VM_USER%@%VMNAME%
rem kitty -P %VM_SSHPORT% -pw %VM_PASS% -4 %VM_USER%@%VMNAME%
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME% && exit /b 2
exit /b 0
