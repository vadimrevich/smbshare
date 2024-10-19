echo on
rem *******************************************************
rem python-3.8-amd64.install.bat
rem Install Python 3.8 at Specified Directory
rem *******************************************************
@echo off
set UTIL=C:\Util
set pathCMD=%SystemRoot%\system32
set PY38X86=C:\Python38.x86
set PYEXE=python-3.8.10.exe
set PYTH=%PY38X86%
%UTIL%\curl.exe https://www.python.org/ftp/python/3.8.10/%PYEXE% -k -o %TEMP%\%PYEXE%
%TEMP%\%PYEXE% /quiet InstallAllUsers=1 TargetDir=%PYTH% DefaultAllUsersTargetDir=%PYTH% AssociateFiles=0
%pathCMD%\reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PY38X86 /t REG_SZ /d %PYTH% /f