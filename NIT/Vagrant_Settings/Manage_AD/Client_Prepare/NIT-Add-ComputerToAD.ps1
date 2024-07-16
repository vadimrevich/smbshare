Param
(
[Parameter (Mandatory=$true, Position=1)]
[System.Management.Automation.PSCredential]$Crededential
)

<#
    .SYNOPSIS
        This Script will Add the Current Computer into AD Domain
    .DESCRIPTION
        This Script will Add the Current Computer into AD Domain
        with Domain Credential <Credential>. Doman and Domain Controller
        will Set at Script body
	The Script will Require Elevated Privileges and need Restart after Run
    .NOTES
    	File name: NIT-Add-ComputerToAD.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2024-01-02
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2024-01-03) Script created
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
### NetBIOS Domain Name
$aDomain="peter.yuden.local"
### NetBIOS Primary Domain Controller Server Name
$aDC="PETER\W2K22-AD"

## Test if Elevated Run
##
if ((Test-Admin) -eq $false)  {
    Write-Host "Error! The Script must be Run with Elevated Privileges.`nExit.`n"
    Exit 17
}
##### Run a Payload
##
Add-Computer -DomainName $aDomain -Credential $Credential -PassThru -Verbose

