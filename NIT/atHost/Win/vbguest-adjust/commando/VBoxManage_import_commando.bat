@echo on
rem *******************************************************
rem VBoxManage.bat
rem This Script Call VBoxManage.exe for Oracle
rem VirtualBox CLI Manager
rem *******************************************************
@echo off
setlocal EnableExtensions DisableDelayedExpansion

set "Reg32=%SystemRoot%\System32\reg.exe"
if not "%ProgramFiles(x86)%" == "" set "Reg32=%SystemRoot%\SysWOW64\reg.exe"

set "DownloadShellFolder="
for /F "skip=1 tokens=1,2*" %%T in ('%Reg32% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "{374DE290-123F-4565-9164-39C4925E467B}" 2^>nul') do (
    if /I "%%T" == "{374DE290-123F-4565-9164-39C4925E467B}" (
        set "DownloadShellFolder=%%V"
        goto GetDownloadDirectory
    )
)

:GetDownloadDirectory
set "DownloadDirectory="
for /F "skip=1 tokens=1,2,3*" %%S in ('%Reg32% query "HKCU\Software\Microsoft\Internet Explorer" /v "Download Directory" 2^>nul') do (
    if /I "%%S" == "Download" (
        if /I "%%T" == "Directory" (
            set "DownloadDirectory=%%V"
            goto GetSaveDirectory
        )
    )
)

:GetSaveDirectory
set "SaveDirectory="
for /F "skip=1 tokens=1,2,3*" %%S in ('%Reg32% query "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Save Directory" 2^>nul') do (
    if /I "%%S" == "Save" (
        if /I "%%T" == "Directory" (
            set "SaveDirectory=%%V"
            goto OutputResults
        )
    )
)

:OutputResults
cls
echo/

if not exist "%USERPROFILE%\Downloads" goto OutputShellFolder
echo Download directory of user account is:
echo/
echo   %USERPROFILE%\Downloads
echo/
echo/

:OutputShellFolder
if not defined DownloadShellFolder goto OutputDownloadDir
if "%DownloadShellFolder:~-1%" == "\" set "DownloadShellFolder=%DownloadShellFolder:~0,-1%"
echo Download shell folder of user account is:
echo/
echo   %DownloadShellFolder%
echo/
echo/

:OutputDownloadDir
if not defined DownloadDirectory goto OutputSaveDir
if "%DownloadDirectory:~-1%" == "\" set "DownloadDirectory=%DownloadDirectory:~0,-1%"
echo Download directory of Internet Explorer is:
echo/
echo   %DownloadDirectory%
echo/
echo/

:OutputSaveDir
if not defined SaveDirectory goto EndBatch
if "%SaveDirectory:~-1%" == "\" set "SaveDirectory=%SaveDirectory:~0,-1%"
echo Save directory of Internet Explorer is:
echo/
echo   %SaveDirectory%

:EndBatch

@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=VBoxManagements
set REDACT=
set FIRM=NIT
set PRODUCT_FOLDER_REMOTE=%FIRM%/%PRODUCT_NAME%/

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set Variables
rem
set VBoxBaseFolder=C:\VBox_VMS

set VBoxManageEXE="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
set GuestVM=commando
set GuestImportFileName=commando.ova
rem set FILEPATHTEMP=D:\yuden\Documents\Virtual_Machines\ISO\vbox-ova
set FILEPATHTEMP=%DownloadShellFolder%
set CPUS=2
set MEMORY=2048
rem set CMDLINE="%*"
set CMDLINE_001="unregistervm %GuestVM% --delete"
set CMDLINE_002="import %TPDL%\%GuestImportFileName% --vsys 0 --vmname=%GuestVM% --basefolder=%VBoxBaseFolder% --cpus=%CPUS% -memory=%MEMORY%"
set CMD_001="del /Q /F %TPDL%\%GuestImportFileName%"
set CMD_002="copy /v %FILEPATHTEMP%\%GuestImportFileName% %TPDL%\%GuestImportFileName%"

rem Derivatives
set CMDLINE_001=%CMDLINE_001:"=%
set CMDLINE_002=%CMDLINE_002:"=%
set CMD_001=%CMD_001:"=%
set CMD_002=%CMD_002:"=%

rem Check Integrity
rem
if not exist  %DownloadShellFolder% echo  %DownloadShellFolder% is not found && exit /b 1
if not exist  %FILEPATHTEMP% echo  %FILEPATHTEMP% is not found && exit /b 1

if not exist %VBoxManageEXE% echo %VBoxManageEXE% is not found && exit /b 1
if not exist  %FILEPATHTEMP%\%GuestImportFileName% echo  %FILEPATHTEMP%\%GuestImportFileName% is not found && exit /b 1
if exist %VBoxBaseFolder% goto :SKIP_BASEFOLDER

echo %VBoxBaseFolder% is not Found
exit /b 1

:SKIP_BASEFOLDER

rem Run Payload

rem Delete Old OVA File an Copy New
%CMD_001%
%CMD_002%

rem Delete Old Virtual Machine
rem
%VBoxManageEXE% %CMDLINE_001%

rem Check Integrity
if not exist %TPDL%\%GuestImportFileName% echo %TPDL%\%GuestImportFileName% is not found && exit /b 1

rem Import Virtual Machine
rem
%VBoxManageEXE% %CMDLINE_002% 

rem Delete OVA File
rem
%CMD_001%

exit /b 0
