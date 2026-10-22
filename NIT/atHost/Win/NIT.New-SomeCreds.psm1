#Requires -Version 5.1

<#
.SYNOPSIS
    This Script will Create Some Windows Credentials
.DESCRIPTION
    This Script will Create Some Windows Credentials
    for Pentesting and Remote Access via WinRM
    on Windows 10 Local Computer
.NOTES
    File name: NIT.New-SomeCreds.psm1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2026-01-19
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2026-01-19) Script created
    1.0.1 - 
#>
###########################################################
# IMPORTANT!!!
# Some variables must be Changed
# Place this script at Working Directory
###########################################################

### Some Variables

### Must Be Changed

$VMName="W2K12-AD02"
$SomePass = "0A9s8d7F"
$SomeUser = "user"
$ComputerName="W2K12-AD"

### May NOT be changed

$SecSomePath = ConvertTo-SecureString -AsPlainText $SomePass -Force
$Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $SomeUser,$SecSomePath

Export-ModuleMember -Variable *
