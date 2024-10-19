@echo on
rem *******************************************************
rem get.windows.version.wmi.bat
rem *******************************************************
@echo off

wmic os get BuildNumber,Caption,Codeset,CSName,OSArchitecture,OSLanguage,RegisteredUser,Status,Version,WindowsDirectory,LocalDateTime /value

for %%i in (
 XP
 Vista
 7
 8
 8.1
 10
 11
) do (
 wmic os get caption| (
 >nul findstr /ilc:"Windows %%i"
 )&& (
 set OS=%%i
 )
)
if defined OS (
 echo Windows %OS%
) else (
 echo ???
)
pause>nul
exit /b 0