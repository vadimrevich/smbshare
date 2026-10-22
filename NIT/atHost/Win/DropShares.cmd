::DropShares.cmd
@echo off&&cls&&goto :Begin
 
:DeleteShare
  set shareName=%~1
  :: если последний символ доллар то шару не трогаем, валюта еще пригодиться
  :: остальные удаляем
  if "%shareName:~-1%" NEQ "$" (   
    net share /DELETE %shareName%
  )
goto :EOF
 
:Main
  :: перебираем все шары доступные на компьютере
  for /F "tokens=1" %%f in ('net share') DO (
    if EXIST \\%COMPUTERNAME%\%%f (
      call :DeleteShare "%%f"
    )
  )
goto :EOF
 
:Begin
Call :Main
