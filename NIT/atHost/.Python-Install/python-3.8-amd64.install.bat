echo on
rem *******************************************************
rem python-3.8-amd64.install.bat
rem Install Python 3.8 at Specified Directory
rem *******************************************************
@echo off
set UTIL=C:\Util
set pathCMD=%SystemRoot%\system32
set PY38X64=C:\Python38.x64
set PYEXE=python-3.8.10-amd64.exe
set PYTH=%PY38X64%
%UTIL%\curl.exe https://www.python.org/ftp/python/3.8.10/%PYEXE% -k -o %TEMP%\%PYEXE%
%TEMP%\%PYEXE% /quiet InstallAllUsers=1 TargetDir=%PYTH% DefaultAllUsersTargetDir=%PYTH% AssociateFiles=0
%pathCMD%\reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PY38X64 /t REG_SZ /d %PYTH% /f