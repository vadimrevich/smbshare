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
set VBoxSVCEXE="C:\Program Files\Oracle\VirtualBox\VBoxSVC.exe"
set VBoxSDSEXE="C:\Program Files\Oracle\VirtualBox\VBoxSDS.exe"
set VBoxEXE="C:\Program Files\Oracle\VirtualBox\VirtualBox.exe"
set VBoxVMEXE="C:\Program Files\Oracle\VirtualBox\VirtualBoxVM.exe"
set VBoxHeadlEXE="C:\Program Files\Oracle\VirtualBox\VBoxHeadless.exe"
set VBoxRule="VBox Input Rules"
set CMDLINE="%*"

rem Derivatives
set CMDLINE=%CMDLINE:"=%

rem Run Payload
netsh advfirewall firewall delete rule name=%VBoxRule%
netsh advfirewall firewall add rule name=%VBoxRule% dir=in action=allow program=%VBoxManageEXE% enable=yes
netsh advfirewall firewall add rule name=%VBoxRule% dir=in action=allow program=%VBoxSVCEXE% enable=yes
netsh advfirewall firewall add rule name=%VBoxRule% dir=in action=allow program=%VBoxSDSEXE% enable=yes
netsh advfirewall firewall add rule name=%VBoxRule% dir=in action=allow program=%VBoxEXE% enable=yes
netsh advfirewall firewall add rule name=%VBoxRule% dir=in action=allow program=%VBoxVMEXE% enable=yes
netsh advfirewall firewall add rule name=%VBoxRule% dir=in action=allow program=%VBoxHeadlEXE% enable=yes
