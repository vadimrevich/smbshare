@echo on
rem *******************************************************
rem Uninstall-MSSQLEXPRES2022.bat
rem *******************************************************
@echo off

rem Set a Directory
rem
set InstallDir=C:\Downloads\SQLEXPR_2022

%InstallDir%\Setup.exe /ConfigurationFile=%InstallDir%\ConfigurationFile-un.ini
