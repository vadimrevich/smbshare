@echo on
rem *******************************************************
rem
rem This Script will Check the Remote Authentication
rem with SMB Protocol on Windows Computers
rem
rem PARAMETERS: %1 is a Computer name or User DNS Domain
rem		%2 is a User name with Domain
rem		%3 is a password of a User Name
rem All Parameters are Required
rem RETURNS:	0 Allways
rem		Команда выполнена успешна В списке нет элементов — учётная запись неправильная
rem *******************************************************
@echo off

net.exe use \\%1 %3 /user:%2

set /a res=%errorlevel%

net.exe use * /Delete /Global

echo %res%

exit /b 0

