echo on
rem *******************************************************
rem python-3.8-amd64.install.bat
rem Install Python 3.8 at Specified Directory
rem *******************************************************
@echo off
set %UTIL%=C:\Util
set pathCMD=%SystemRoot%\system32
set PY27X64=C:\Python27.x64
set PYEXE=python-2.7.18.amd64.msi
set PYTH=%PY27X64%
%UTIL%\curl.exe https://www.python.org/ftp/python/2.7.18/%PYEXE% -k -o %TEMP%\%PYEXE%
%pathCMD%\msiexec.exe /i %TEMP%\%PYEXE% /qb InstallAllUsers=1 TargetDir=%PYTH% DefaultAllUsersTargetDir=%PYTH% AssociateFiles=0
%pathCMD%\reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PY27X64 /t REG_SZ /d %PYTH% /f