@echo off
rem *******************************************************
rem lptpeur-ssh.bat
rem This Script will Connect to a Virtual Machine 
rem *******************************************************
@echo off

rem set a variables
rem
set VMNAME=LAPTOP-EURTP
set VM_USER=user
set VM_PASS=0A9s8d7F
set VM_SSHPORT=222
set VM_WINRMPORT=5985
set VM_COMMAND="net.exe start cygsshd"

rem Run Payloads
ping.exe -n 2 -4 %VMNAME% > nul 2> nul
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME% && exit /b 2
rem winrs -r:%VMNAME%:%VM_WINRMPORT% -u:%VM_USER% -p:%VM_PASS% %VM_COMMAND%
rem if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME% with WinRM && exit /b 2
ssh -p %VM_SSHPORT% -4 %VM_USER%@%VMNAME%
rem kitty -P %VM_SSHPORT% -pw %VM_PASS% -4 %VM_USER%@%VMNAME%
if %errorlevel% NEQ 0 echo Cannot connect to %VMNAME% with ssh && exit /b 2
rem winrs -r:%VMNAME% -u:%VM_USER% -p:%VM_PASS% "net stop sshd"
exit /b 0
