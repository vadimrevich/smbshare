@echo on
rem *******************************************************
rem VBoxManage_modvn_compact_kali.bat
rem This Script Call VBoxManage.exe for Oracle
rem VirtualBox CLI Manager
rem The Script will Compact a Guest Machine Virtual Disk
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
set GuestVM=kali
set VDI_DISK=%VBoxBaseFolder%\%GuestVM%\%GuestVM%-disk001.vmdk

set VBoxManageEXE="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
set CMDLINE="%*"
set CMDLINE_NIC="modifyvm %GuestVM% --nic1=nat --mac-address1=%MACAddress%"
set CMDLINE_NATSET001="modifyvm %GuestVM% --nat-pf1=SSH_PORTS%GuestVM%,tcp,,%SSH_PORTS%,,22 --nat-pf1=TELNET_PORTS%GuestVM%,tcp,,%TELNET_PORTS%,,23 --nat-pf1=WEBADM_PORTS%GuestVM%,tcp,,%WEBADM_PORTS%,,10000"
set CMDLINE_NATUNSET001="modifyvm %GuestVM% --nat-pf1 delete SSH_PORTS%GuestVM% --nat-pf1 delete TELNET_PORTS%GuestVM% --nat-pf1 delete WEBADM_PORTS%GuestVM%"
set CMDLINE_COMPACT="modifymedium --compact %VDI_DISK%"

rem Derivatives
set CMDLINE=%CMDLINE:"=%
set CMDLINE_NIC=%CMDLINE_NIC:"=%
set CMDLINE_NATSET001=%CMDLINE_NATSET001:"=%
set CMDLINE_NATUNSET001=%CMDLINE_NATUNSET001:"=%
set CMDLINE_COMPACT=%CMDLINE_COMPACT:"=%

rem Check Integrity
rem
if exist %VBoxBaseFolder% goto :SKIP_BASEFOLDER

echo %VBoxBaseFolder% is not Found
exit /b 1

:SKIP_BASEFOLDER

rem Run Payload
echo on
%VBoxManageEXE% %CMDLINE_COMPACT%

exit /b 0
