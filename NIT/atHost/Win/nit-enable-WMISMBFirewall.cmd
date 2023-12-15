@echo on
rem *******************************************************
rem nit-enable-WMISMBFirewall.cmd
rem Tis Script will Enable a Firewall Rules
rem on local Windows Computer
rem via Windows Shell
rem *******************************************************

rem Set Windows Managements Instrumentation
netsh.exe advfirewall firewall set rule group="windows management instrumentation (wmi)" new enable=yes
netsh.exe advfirewall firewall set rule group="�����㬥��਩ �ࠢ����� Windows (wmi)" new enable=yes
netsh.exe advfirewall firewall set rule group="��騩 ����� � 䠩��� � �ਭ�ࠬ" new enable=yes
netsh.exe advfirewall firewall set rule group="�᭮�� �⥩" new enable=yes
netsh.exe advfirewall firewall set rule group="��������� �ࠢ����� �㦡��" new enable=yes
netsh.exe advfirewall firewall set rule group="��������� �ࠢ����� Windows" new enable=yes
netsh.exe advfirewall firewall set rule group="��������� �ࠢ����� �࠭�����஬ ���⭨�� Windows" new enable=yes
netsh.exe advfirewall firewall set rule group="�������� ࠡ�稩 �⮫ (��������)" new enable=yes

@echo off
rem Delete Users Rules
netsh.exe advfirewall firewall delete rule name="DCOM Firewall Rule"
netsh.exe advfirewall firewall delete rule name="WMI Firewall Rule"
netsh.exe advfirewall firewall delete rule name="UnsecApp Firewall Rule"
netsh.exe advfirewall firewall delete rule name="WMI_OUT Firewall Rule"

rem Set Additional Instrumentation
netsh.exe advfirewall firewall add rule dir=in name="DCOM Firewall Rule" program=%systemroot%\system32\svchost.exe service=rpcss action=allow protocol=TCP localport=any
netsh.exe advfirewall firewall add rule dir=in name="WMI Firewall Rule" program=%systemroot%\system32\svchost.exe service=winmgmt action=allow protocol=TCP localport=any
netsh.exe advfirewall firewall add rule dir=in name="UnsecApp Firewall Rule" program=%systemroot%\system32\wbem\unsecapp.exe action=allow
netsh.exe advfirewall firewall add rule dir=out name="WMI_OUT Firewall Rule" program=%systemroot%\system32\svchost.exe service=winmgmt action=allow protocol=TCP localport=any

rem Turn On DCOM
rem Turn Off Remote UAC Control
reg.exe add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
rem Allow Reverse Call
reg.exe add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Wbem\CIMOM /v AllowAnonymousCallback /t REG_DWORD /d 1 /f
rem Turn On DCOM
reg.exe add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\OLE /v EnableDCOM /t REG_SZ /d Y /f
