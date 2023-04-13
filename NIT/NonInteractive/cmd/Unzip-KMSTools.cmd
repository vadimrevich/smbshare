@echo off
rem *******************************************************
rem Unzip-KMSTools.cmd
rem This Script Unzip the KMS.Tools.zip Files Archive
rem *******************************************************
@echo off

rem
rem Set Directories
rem
set EXEDIR=%~dp0..\Exe
set LocalFolder=C:\.BIN

rem Set Files
rem
set UNZIPEXE=%EXEDIR%\unzip.exe
set ZIPFILE=%LocalFolder%\KMS.Tools.zip

echo Check Integrity....
rem
if not exist %UNZIPEXE% echo %UNZIPEXE% doesn't exist && exit /b 1
if not exist %ZIPFILE% echo %ZIPFILE% doesn't exist && exit /b 1

echo Run Payload...
rem
%UNZIPEXE% -o %ZIPFILE% -d %LocalFolder%

echo The End of the Script %0
exit /b 0

