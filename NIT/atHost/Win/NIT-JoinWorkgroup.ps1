Param (
[Parameter (Mandatory=$true, Position=1)]
[string]$WorkGroup
)

<#
    .SYNOPSIS
        This Script will Join a Current Computer to Pointed Workgroup
        and Restart It
    .DESCRIPTION
        This Script will Join a Current Computer to Pointed Workgroup
    .NOTES
    	File name: NIT-JoinWorkgroup.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2024-05-22
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2024-5-22) Script created
    	1.0.1 - 
#>

# [CmdletBinding()]

function NIT-JoinWorkgroup {
 
   [CmdletBinding()] param (
 
      [string] $WorkGroup
 
   )
   (Get-WmiObject Win32_ComputerSystem).JoinDomainOrWorkgroup($WorkGroup)
}

NIT-JoinWorkgroup($WorkGroup)
Restart-Computer -Force
