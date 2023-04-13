@echo off
set SFXARCH=szbec.exe
set PASS=szbeck
set FOLDER=C:\.BIN\smbshare\Install-Adjust
if not exist "%FOLDER%\%SFXARCH%" goto Error
"%FOLDER%\%SFXARCH%" -p%PASS%
goto Finish
:Error
echo "File %FOLDER%\%SFXARCH% not found" && exit /b 1
rem pause
:Finish
exit /b 0