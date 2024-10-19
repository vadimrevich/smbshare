@echo on
rem *******************************************************
rem VBoxManage.bat
rem This Script Call VBoxManage.exe for Oracle
rem VirtualBox CLI Manager
rem *******************************************************
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
set CMDLINE_002="Oracle_VM_VirtualBox_Extension_Pack*.vbox-extpack"
set CMDLINE_003="-qO - https://download.virtualbox.org/virtualbox/LATEST-STABLE.TXT"


rem set Files
set WGETEXE=C:\Util\wget.exe
set CHOCOEXE=%chocolateyinstall%\choco.exe
set VBoxManageEXE="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"


rem Derivatives
set CMDLINE_002=%CMDLINE_002:"=%
set CMDLINE_003=%CMDLINE_003:"=%

rem Check Integrity
rem
if not exist %WGETEXE% echo %WGETEXE% is not found && exit /b 1
if not exist %CHOCOEXE% echo %CHOCOEXE% is not found && exit /b 1

rem Run Payload

rem Delete Old Extension Pack
del /Q /F %TPDL%\%CMDLINE_002%

rem Get Latest Version of Extension Pack
rem
FOR /F "tokens=* USEBACKQ" %%F IN (`%WGETEXE% %CMDLINE_003%`) DO (
SET LatestVirtualBoxVersion=%%F
)
ECHO Latest Version = %LatestVirtualBoxVersion%

rem Download VirtualBox Extension pack
%WGETEXE% https://download.virtualbox.org/virtualbox/%LatestVirtualBoxVersion%/Oracle_VM_VirtualBox_Extension_Pack-%LatestVirtualBoxVersion%.vbox-extpack -O %TPDL%\Oracle_VM_VirtualBox_Extension_Pack-%LatestVirtualBoxVersion%.vbox-extpack

rem Update Virtualbox
%CHOCOEXE% upgrade -y VirtualBox

rem Install Virtualbox Extension Pack
echo y | %VBoxManageEXE% extpack install --replace %TPDL%\Oracle_VM_VirtualBox_Extension_Pack-%LatestVirtualBoxVersion%.vbox-extpack
