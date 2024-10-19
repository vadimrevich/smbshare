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
set VBoxBaseFolder=C:\VBox_VMS

set VBoxManageEXE="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
set GuestVM=ub64
set GuestImportFileName=ub64.ova
set FILEPATHTEMP=D:\yuden\Documents\Virtual_Machines\ISO\vbox-ova
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
if not exist %VBoxManageEXE% echo %VBoxManageEXE% is not found && exit /b 1
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
