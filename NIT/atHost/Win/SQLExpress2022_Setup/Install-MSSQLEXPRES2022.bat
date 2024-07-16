@echo on
rem *******************************************************
rem Install-MSSQLEXPRES2022.bat
rem *******************************************************
@echo off

rem Set a Directory
rem
set InstallDir=C:\Downloads\SQLEXPR_2022
set APASSWORD=0a9s8d7F

rem %InstallDir%\Setup.exe /SQLSVCPASSWORD="%APASSWORD%" /ASSVCPASSWORD="%APASSWORD%" /AGTSVCPASSWORD="%APASSWORD%" /ISSVCPASSWORD="%APASSWORD%" /RSSVCPASSWORD="%APASSWORD%" /SAPWD="%APASSWORD%" /ConfigurationFile=%InstallDir%\ConfigurationFile.ini
%InstallDir%\Setup.exe /SQLSVCPASSWORD="%APASSWORD%" /ASSVCPASSWORD="%APASSWORD%" /AGTSVCPASSWORD="%APASSWORD%" /ISSVCPASSWORD="%APASSWORD%" /SAPWD="%APASSWORD%" /ConfigurationFile=%InstallDir%\ConfigurationFile.ini
