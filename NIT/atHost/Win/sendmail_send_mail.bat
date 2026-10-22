@echo off
rem *******************************************************
rem sendmail_send_mail.bat
rem This Script will send a emale from Windiws Command
rem Shell via fake sendmail windows script
rem
rem UnxUtils must be install
rem *******************************************************
@echo off

rem Set Variables

set FROMMAIL=no-reply@clients.netip6.ru
set FROMNAME="No-Reply"
set TOMAIL=vadimrevich21@gmail.com
set aHeader=.\smtp-header_win.txt
set aBody=.\test-message.txt

rem run Payloads
cat %aHeader% %aBody% | %UTIL%\sendmail.exe
