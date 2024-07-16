<#
    .SYNOPSIS
        This Script will Create a Local User $aUser
    .DESCRIPTION
        This Script will Create a Local System User $aUser
        with Password $aPass on Local Windows Computer System
	The Script will Require Elevated Privileges
    .NOTES
    	File name: NIT-New-LocalUser.ps1
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
$aUser = "user"
$aPass = "0A9s8d7F"
$aUserFullName = "Ordinary User"
$aUserDescription = "Ordinary User for Local System"

### Default User Local Groups
$aUserGroupAdd001 = "Администраторы"
$aUserGroupDel001 = "Пользователи"

### Derivative Variables
$aSecurePass = ConvertTo-SecureString $aPass -AsPlainText -Force

## Test if Elevated Run
##
if ((Test-Admin) -eq $false)  {
    Write-Host "Error! The Script must be Run with Elevated Privileges.`nExit.`n"
    Exit 17
}

##### Run Payloads #####
##
New-LocalUser -Name $aUser -FullName $aUserFullName `
              -Description $aUserDescription `
              -Password $aSecurePass `
              -Group $aUserGroupAdd001 `
              -PasswordNeverExpires $True

Remove-LocalGroupMember -Group $aUserGroupDel001 –Member $aUser
