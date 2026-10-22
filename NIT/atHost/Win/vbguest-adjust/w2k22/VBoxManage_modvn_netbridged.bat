@echo on
rem *******************************************************
rem VBoxManage_modvn_netnat_ub64_set.bat
rem This Script Call VBoxManage.exe for Oracle
rem VirtualBox CLI Manager
rem The Script Set and Modify NetNAT Interface
rem
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
set GuestVM=w2k22
set MACAddress=08002719CD68

set VBoxManageEXE="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
set CMDLINE="%*"
set BRIDGE_ADAPTER="Hyper-V Virtual Ethernet Adapter #2"
set CMDLINE_NICBRIDGE="modifyvm %GuestVM% --nic1=bridged --mac-address1=%MACAddress% --nic-promisc1=allow-all"
set CMDLINE_NICNAT="modifyvm %GuestVM% --nic1=nat  --mac-address1=%MACAddress%"


rem Derivatives
set CMDLINE=%CMDLINE:"=%
set CMDLINE_NICBRIDGE=%CMDLINE_NICBRIDGE:"=%
set CMDLINE_NICNAT=%CMDLINE_NICNAT:"=%

rem Check Integrity
rem
if exist %VBoxBaseFolder% goto :SKIP_BASEFOLDER

echo %VBoxBaseFolder% is not Found
exit /b 1

:SKIP_BASEFOLDER

rem Run Payload
echo on
%VBoxManageEXE% %CMDLINE_NICBRIDGE% --bridge-adapter1=%BRIDGE_ADAPTER%
rem %VBoxManageEXE% %CMDLINE_NICNAT%


exit /b 0
