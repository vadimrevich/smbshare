@echo on
rem *******************************************************
rem nit-enable-WinRMPSExec.cmd
rem Tis Script will Enable WinRM on Windows Computer
rem %COMPUTERNAME0% via Sysinternals PSExec
rem *******************************************************
@echo off

rem Set Computer Name (may be changed)
rem set COMPUTERNAME0=localhost
set COMPUTERNAME0=win.netip4.ru

rem Set User Name and Password (must be change)
set AUSER0=WIN\vagrant
set APASS0=0a9s8d7F

rem Run Payload
rem psexec.exe \\%COMPUTERNAME0% -h -s powershell.exe Enable-PSRemoting -Force
psexec.exe \\%COMPUTERNAME0% -u %AUSER0% -p %APASS0% -i -h -s powershell.exe Enable-PSRemoting -Force
