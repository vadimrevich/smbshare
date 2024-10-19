@echo off
rem *******************************************************
rem diana-winrm.bat
rem This Script will Connect to a Laptop
rem *******************************************************
@echo off

rem set a variables
rem
set VMNAME=diana-laptop.yudenisov.internal
set DOMAIN=DIANA-LAPTOP
rem set VM_USER=Администратор
set VM_USER=yuden
set VM_PASS=P@ssp0rtSaratov
set VM_SSHPORT=5985

rem Run Payloads
ping.exe -n 2 -4 %VMNAME% > nul 2> nul
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME% && exit /b 2
winrs -r:%VMNAME%:%VM_SSHPORT% -u:%DOMAIN%\%VM_USER% -p:%VM_PASS% cmd.exe
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME%:%VM_SSHPORT% && exit /b 2
exit /b 0
