@echo on
rem This script is created the local user MSSQLSR and register it
rem As local administrator
rem It also registered Group "Domain Administrators" as local group
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

%SystemRoot%\System32\net.exe user %aLogin% %aPass% /add
%SystemRoot%\System32\net.exe localgroup Администраторы %aLogin% /add
%SystemRoot%\System32\net.exe localgroup Пользователи %aLogin% /delete
%SystemRoot%\System32\net.exe localgroup Users %aLogin% /delete
%SystemRoot%\System32\net.exe localgroup Administrators %aLogin% /add
%SystemRoot%\System32\net.exe localgroup Администраторы %DomainUser%\"Администраторы домена" /add /DOMAIN
%SystemRoot%\System32\net.exe localgroup Administrators %DomainUser%\"Domain Administrators" /add /DOMAIN
%SystemRoot%\System32\net.exe localgroup Администраторы %DomainUser%\"Пользователи домена" /delete /DOMAIN
%SystemRoot%\System32\net.exe localgroup Administrators %DomainUser%\"Domain Users" /delete /DOMAIN
%SystemRoot%\System32\net.exe localgroup Администраторы %DomainUser%\%aLogin% /add /DOMAIN
%SystemRoot%\System32\net.exe localgroup Administrators %DomainUser%\%aLogin% /add /DOMAIN
call %WorkingDir%\reg_import_file.bat %WorkingDir%\winlogon-SpecialAccounts.reg
chcp 866
