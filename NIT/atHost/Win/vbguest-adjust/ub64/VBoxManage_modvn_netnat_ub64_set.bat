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
set GuestVM=ub64
set MACAddress=080027C3CDDC

rem POrts
rem
set SSH_PORTS=15022
set TELNET_PORTS=15023
set WEBADM_PORTS=15000

set VBoxManageEXE="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
set CMDLINE="%*"
set CMDLINE_NIC="modifyvm %GuestVM% --nic1=nat --mac-address1=%MACAddress%"
set CMDLINE_NATSET001="modifyvm %GuestVM% --nat-pf1=SSH_PORTS%GuestVM%,tcp,,%SSH_PORTS%,,22 --nat-pf1=TELNET_PORTS%GuestVM%,tcp,,%TELNET_PORTS%,,23 --nat-pf1=WEBADM_PORTS%GuestVM%,tcp,,%WEBADM_PORTS%,,10000"
set CMDLINE_NATUNSET001="modifyvm %GuestVM% --nat-pf1 delete SSH_PORTS%GuestVM% --nat-pf1 delete TELNET_PORTS%GuestVM% --nat-pf1 delete WEBADM_PORTS%GuestVM%"

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
%VBoxManageEXE% %CMDLINE_NATSET001%
rem %VBoxManageEXE% %CMDLINE_NATUNSET001%

exit /b 0
