<#
.SYNOPSIS
    This Script will Copy Defeat Files
.DESCRIPTION
    This Script will Copy Defeat Files
    for Local Computer.
.NOTES
    File name: NIT-Copy-W2K22-AD.0001.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-08-24
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-8-24) Script created
    1.0.1 - 
#>
# param([switch]$Elevated)

# Set Variables

# User
$VM_USER="Администратор"

# Password
$VM_PASS="0A9s8d7F"

# Host
$VM_HOST="w2k22-ad.yudenisov.internal"

# Port
$VM_PORT="5985"

# Set Remote Host Directory
$aDirName = "nit-iso.dir"

# Derivative Variables
$RemoteUserProfile=Join-Path -Path "C:\Users" -ChildPath $VM_USER
$RemoteDirPath=Join-Path -Path $RemoteUserProfile -ChildPath $aDirName
$LocalDirPath=Join-Path -Path $env:USERPROFILE -ChildPath $aDirName

# Derivative Variables
$VM_SECPASS=ConvertTo-SecureString -AsPlainText $VM_PASS -Force
$VM_CRED = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $VM_USER,$VM_SECPASS

# Set Session Variable
$sess = New-PSSession -ComputerName $VM_HOST -Credential $VM_CRED -Authentication Negotiate -Port $VM_PORT

# Invoke-Command -Session $sess -ScriptBlock {New-Item -Path $RemoteDirPath}
Copy-Item -ToSession $sess -Recurse -Path $LocalDirPath -Destination $RemoteUserProfile

Remove-PSSession -Session $sess



