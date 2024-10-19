<#
.SYNOPSIS
    This Script will Set New w2k22-ad Session
    for Local Computer.
.DESCRIPTION
    This Script will Set New w2k22-ad Session
.NOTES
    File name: New-W2K22-AD.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-07-23
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-07-23) Script created
    1.0.1 - 
#>
# param([switch]$Elevated)

# Set Variables

# User
$VM_USER="Администратор"
# $VM_USER="user"

# Password
$VM_PASS="0A9s8d7F"

# Host
$VM_GUEST="w2k22-ad"

# Derivative Variables
$VM_SECPASS=ConvertTo-SecureString -AsPlainText $VM_PASS -Force
$VM_CRED = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $VM_USER,$VM_SECPASS

# Run Payload
return New-PSSession -VMName $VM_GUEST -Credential $VM_CRED



