@echo off
rem *******************************************************
rem vmwi-winrs.bat
rem This Script will Connect to a Virtual Machine 
rem *******************************************************
@echo off

rem set a variables
rem
set VMNAME=win.netip4.ru
set VM_USER=vagrant
set VM_PASS=0a9s8d7F
set VM_SSHPORT=22
set VM_WINRMPORT=5985
set VM_COMMAND="cmd.exe"

rem Run Payloads
ping.exe -n 2 -6 %VMNAME% > nul 2> nul
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME% && exit /b 2
winrs -r:%VMNAME%:%VM_WINRMPORT% -u:%VM_USER% -p:%VM_PASS% %VM_COMMAND%
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME% with WinRM && exit /b 2
rem winrs -r:%VMNAME% -u:%VM_USER% -p:%VM_PASS% "net stop sshd"
exit /b 0
