@echo on
rem *******************************************************
rem VBoxManage_modvn_netnat_w2k25_set.bat
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
set GuestVM=w2k25
set MACAddress=08002719CD68

rem POrts
rem
set SSH_PORTS=16022
set WINRM_PORTS=16589
set RDP_PORTS=16389

set VBoxManageEXE="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
set CMDLINE="%*"
set CMDLINE_NIC="modifyvm %GuestVM% --nic1=nat --mac-address1=%MACAddress%"
set CMDLINE_NATSET001="modifyvm %GuestVM% --nat-pf1=SSH_PORTS%GuestVM%,tcp,,%SSH_PORTS%,,22 --nat-pf1=WINRM_PORTS%GuestVM%,tcp,,%WINRM_PORTS%,,5985 --nat-pf1=RDP_PORTS%GuestVM%,tcp,,%RDP_PORTS%,,3389"
set CMDLINE_NATUNSET001="modifyvm %GuestVM% --nat-pf1 delete SSH_PORTS%GuestVM% --nat-pf1 delete WINRM_PORTS%GuestVM% --nat-pf1 delete RDP_PORTS%GuestVM%"

rem Derivatives
set CMDLINE=%CMDLINE:"=%
set CMDLINE_NIC=%CMDLINE_NIC:"=%
set CMDLINE_NATSET001=%CMDLINE_NATSET001:"=%
set CMDLINE_NATUNSET001=%CMDLINE_NATUNSET001:"=%

rem Check Integrity
rem
if exist %VBoxBaseFolder% goto :SKIP_BASEFOLDER

echo %VBoxBaseFolder% is not Found
exit /b 1

:SKIP_BASEFOLDER

rem Run Payload
echo on
%VBoxManageEXE% %CMDLINE_NIC%
rem %VBoxManageEXE% %CMDLINE_NATSET001%
%VBoxManageEXE% %CMDLINE_NATUNSET001%

exit /b 0
