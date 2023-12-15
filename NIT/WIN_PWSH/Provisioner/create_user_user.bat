@echo on
rem ***
rem create_user_user.bat
rem This Script Create Administrator User
rem "user" with password "0A9s8d7F"
rem ***
@echo off

rem Create variables
set login=user
set password=0A9s8d7F
set admingroup=Администраторы
set usergroup=Пользователи
set admingroupEn=Administrators
set usergroupEn=Users
set /a ANSICODEPAGE=1251
set /a OEMCODEPAGE=866

rem Run Algorythm
rem chcp %ANSICODEPAGE%
chcp %OEMCODEPAGE%
net user %login% %password% /add
net user %login% %password%
net localgroup %admingroup% %login% /ADD
net localgroup %usergroup% %login% /DELETE
net localgroup %admingroupEn% %login% /ADD
net localgroup %usergroupEn% %login% /DELETE
chcp %OEMCODEPAGE%
