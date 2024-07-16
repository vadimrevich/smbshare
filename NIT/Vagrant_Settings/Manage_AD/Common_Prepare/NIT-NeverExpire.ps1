<#
    .SYNOPSIS
        This Script will Set Flag 'Never Expire' for some Local Users
    .DESCRIPTION
        This Script will Set a Flag "The Password is Never Expire"
        for some Local Users
        with Password $aPass on Local Windows Computer System
	The Script will Require Elevated Privileges
    .NOTES
    	File name: NIT-NeverExpire.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2024-01-06
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2024-01-06) Script created
    	1.0.1 - 
#>

# [CmdletBinding()]

##### A Function to Test Elevated Run
##

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

##### Set a Variables
##
$aUser001 = "Àäìèíèñòðàòîð"
$aUser002 = "user"
$aUser003 = "MSSQLSR"

## Test if Elevated Run
##
if ((Test-Admin) -eq $false)  {
    Write-Host "Error! The Script must be Run with Elevated Privileges.`nExit.`n"
    Exit 17
}

##### Run Payloads #####
##
Set-LocalUser -Name $aUser001 –PasswordNeverExpires $True
Set-LocalUser -Name $aUser002 –PasswordNeverExpires $True
Set-LocalUser -Name $aUser003 –PasswordNeverExpires $True
