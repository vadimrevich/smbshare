@echo off
rem *******************************************************
rem CreateFolder-AWSome.bat
rem This Script will Download and Run Script
rem for Make C:\pub1\util\Zlovred\Awesome Folder
rem *******************************************************
@echo off


rem Set a Variables

rem Metadata

set PRODUCT_NAME=NIT.RTBD
set SUBPRODUCT_NANE=Awesome
set PRODUCT_NAME_FOLDER=
set FIRM_NAME=NIT

setlocal EnableExtensions DisableDelayedExpansion

set "Reg32=%SystemRoot%\System32\reg.exe"
if not "%ProgramFiles(x86)%" == "" set "Reg32=%SystemRoot%\SysWOW64\reg.exe"

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End
echo Temp Folder = %TPDL%

rem Set CURDIR Directoru
set CurDIR=%CD%
set SCRIPTDIR=%~dp0

echo Current Directory = %CurDIR%
echo Script Directory = %SCRIPTDIR%

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


rem Get a Downloads Directory
rem
if not defined DownloadShellFolder echo DownloadShellFolder is not Defined  && exit /b 1
if not exist %DownloadShellFolder% echo %DownloadShellFolder% is not Found && exit /b 1
echo My Download = %DownloadShellFolder%

rem Set My Documents Variable...
rem
for /f "tokens=2,*" %%i in ('%Reg32% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Personal"  ^|findstr /i "REG_"') do set MyDocuments=%%j

if not defined MyDocuments (echo Variable My Documents Folder not Defined && exit /b 1)
if not exist %MyDocuments% echo %MyDocuments% is not Found && exit /b 1
echo My Documents = %MyDocuments%

rem Set My Desktop Variable...
rem
for /f "tokens=2,*" %%i in ('%Reg32% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"  ^|findstr /i "REG_"') do set MyDesktop=%%j

if not defined MyDesktop (echo Variable My Desktop Folder not Defined && exit /b 1)
if not exist %MyDesktop% echo %MyDesktop% is not Found && exit /b 1
echo My Desktop = %MyDesktop%

rem Set My Video Variable...
rem
for /f "tokens=3,*" %%i in ('%Reg32% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "My Video"  ^|findstr /i "REG_"') do set MyVideo=%%j

if not defined MyVideo (echo Variable My Video Folder not Defined && exit /b 1)
if not exist %MyVideo% echo %MyVideo% is not Found && exit /b 1
echo My Video = %MyVideo%

rem Set My Pictures Variable...
rem
for /f "tokens=3,*" %%i in ('%Reg32% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "My Pictures"  ^|findstr /i "REG_"') do set MyPictures=%%j

if not defined MyPictures (echo Variable My Pictures Folder not Defined && exit /b 1)
if not exist %MyPictures% echo %MyPictures% is not Found && exit /b 1
echo My Pictures = %MyPictures%

rem Set My Music Variable...
rem
for /f "tokens=3,*" %%i in ('%Reg32% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "My Music"  ^|findstr /i "REG_"') do set MyMusic=%%j

if not defined MyMusic (echo Variable My Music Folder not Defined && exit /b 1)
if not exist %MyMusic% echo %MyMusic% is not Found && exit /b 1
echo My Music = %MyMusic%

rem Check UserProfile Variable...
rem
if not defined UserProfile (echo Variable UserProfile Folder not Defined && exit /b 1)
if not exist %UserProfile% echo %UserProfile% is not Found && exit /b 1
echo User Profile Folder = %UserProfile%

rem Set Powershell
set POSHEXE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe
if not exist %POSHEXE% echo The file %POSHEXE% is not found && exit /b 1

rem set host
set host=http://file.netip4.ru:80/PROGS/%FIRM_NAME%/%PRODUCT_NAME%/%SUBPRODUCT_NANE%/

rem set a LocalDir
set LocalDir=%DownloadShellFolder%

rem Set a File Path
set LocalPath=%LocalDir%\New-AwesomeFolder.ps1
set RemoteFile=%host%New-AwesomeFolder.ps1

rem Run Payloads
if exist %LocalPath% del %LocalPath% /Q /F

%POSHEXE% -NoProfile -NoLogo -ExecutionPolicy Bypass -Command "$wc = New-Object System.Net.WebClient;$wc.DownloadFile('%RemoteFile%', '%LocalPath%')"

if not exist %LocalPath% echo The File %LocalPath% can not Download && exit /b 1
%POSHEXE% -NoProfile -NoLogo -ExecutionPolicy Bypass -File "%LocalPath%"

:End
echo Success script %0 executed
exit /b 0
