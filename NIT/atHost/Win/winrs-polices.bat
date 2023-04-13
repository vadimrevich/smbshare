@echo on
rem *******************************************************
rem
rem Add WinRM Secure Policies at a Registry as a Group Policy
rem
rem *******************************************************
@echo off
%SystemRoot%\System32\reg.exe add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
