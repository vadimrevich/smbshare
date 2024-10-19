echo on
rem *******************************************************
rem python-3.7-amd64.install.bat
rem Install Python 3.7 at Specified Directory
rem *******************************************************
@echo off
set UTIL=C:\Util
set pathCMD=%SystemRoot%\system32
set PY37X64=C:\Python37.x64
set PYEXE=python-3.7.9-amd64.exe
set PYTH=%PY37X64%
%UTIL%\curl.exe https://www.python.org/ftp/python/3.7.9/%PYEXE% -k -o %TEMP%\%PYEXE%
%TEMP%\%PYEXE% /quiet InstallAllUsers=1 TargetDir=%PYTH% DefaultAllUsersTargetDir=%PYTH% AssociateFiles=0
%pathCMD%\reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PY37X64 /t REG_SZ /d %PYTH% /f
