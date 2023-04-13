@echo on
rem ***
rem create_vagrant_user.bat
rem This Script Create Administrator User
rem "vagrant" with password "vagrant"
rem ***
rem @echo off

rem Create variables
set login=vagrant
set password=vagrant
set admingroup=Администраторы
set usergroup=Пользователи
set /a ANSICODEPAGE=1251
set /a OEMCODEPAGE=866

rem Run Algorythm
rem chcp %ANSICODEPAGE%
net user %login% %password% /add
net user %login% %password%
net localgroup %admingroup% %login% /ADD
net localgroup %usergroup% %login% /DELETE
chcp %OEMCODEPAGE%
