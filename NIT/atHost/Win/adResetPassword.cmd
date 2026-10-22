@echo on
rem This Script will Reset a Password at MSSQLSR account
@echo off

rem Set Accounts
rem
set AUSER0=MSSQLSR
set APASS0=Admin01234

rem Run Payload
%SystemRoot%\System32\net.exe user %AUSER0% %APASS0%

