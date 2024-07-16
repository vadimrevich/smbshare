@echo on
rem *******************************************************
rem nit.make_masterbrowser.reg.cmd
rem This Script will Assign a Current Windows Computer
rem as SMB Master Browser
rem *******************************************************
@echo off

rem Run Payloads
%SystemRoot%\System32\reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Browser\Parameters" /v IsDomainMaster /t REG_SZ /d True /f
%SystemRoot%\System32\reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Browser\Parameters" /v MaintainServerList /t REG_SZ /d Yes /f
