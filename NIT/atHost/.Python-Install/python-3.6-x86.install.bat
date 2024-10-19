echo on
rem *******************************************************
rem python-3.6-x86.install.bat
rem Install Python 3.6 at Specified Directory
rem *******************************************************
@echo off
set UTIL=C:\Util
set pathCMD=%SystemRoot%\system32
set PY36X86=C:\Python36.x86
set PYEXE=python-3.6.8.exe
set PYTH=%PY36X86%
%UTIL%\curl.exe https://www.python.org/ftp/python/3.6.8/%PYEXE% -k -o %TEMP%\%PYEXE%
%TEMP%\%PYEXE% /quiet InstallAllUsers=1 TargetDir=%PYTH% DefaultAllUsersTargetDir=%PYTH% AssociateFiles=0
%pathCMD%\reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PY36X86 /t REG_SZ /d %PYTH% /f

