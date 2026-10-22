<#
.SYNOPSIS
    This Script Add a New Administrator
.DESCRIPTION
    This Script Add a New Administrator
    with Name user
    on Windows 10 Local Computer
.NOTES
    File name: NIT.New-AdminUser.00.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2025-04-13
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2025-04-13) Script created
    1.0.1 - 
#>
param([switch]$Elevated)

### Set Global Variables

$aUser = "user"
$aFullUserName = "Ordinary Admin"
$aDescription = "Ordinary Local Computer Admin"
$PlainPassword = "0A9s8d7F"
$SecurePassword = ConvertTo-SecureString $PlainPassword -AsPlainText -Force
$AdminSID = "S-1-5-32-544"
$UserSID = "S-1-5-32-545"


### Run Payloads
New-LocalUser -AccountNeverExpires -Description $aDescription -FullName $aFullUserName -Name $aUser -Password $SecurePassword -PasswordNeverExpires
Add-LocalGroupMember -Member $aUser -SID $AdminSID
Remove-LocalGroupMember -Member $aUser -SID $UserSID


