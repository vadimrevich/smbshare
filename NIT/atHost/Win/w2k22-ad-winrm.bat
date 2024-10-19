@echo off
rem *******************************************************
rem w2k22-ad-winrm.bat
rem This Script will Connect to a Virtual Machine 
rem *******************************************************
@echo off

rem set a variables
rem
set VMNAME=w2k22-ad.yudenisov.internal
set VM_USER=Администратор
rem set VM_USER=user
set VM_PASS=0A9s8d7F
set VM_SSHPORT=5985

rem Run Payloads
ping.exe -n 2 -4 %VMNAME% > nul 2> nul
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME% && exit /b 2
winrs -r:%VMNAME%:%VM_SSHPORT% -u:%VM_USER% -p:%VM_PASS% cmd.exe
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME%:%VM_SSHPORT% && exit /b 2
exit /b 0
