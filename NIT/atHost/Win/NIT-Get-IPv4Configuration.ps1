Param (
[Parameter (Mandatory=$true, Position=1)]
[string]$IfAliaceTemplate
)

<#
    .SYNOPSIS
        This Script will Get an Information of Intrfaces
    .DESCRIPTION
        This Script will Get an Information of Intrfaces
	for String Template of Interface Aliace
    .NOTES
    	File name: NIT-Get-IPv4Configuration.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-11-12
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-11-12) Script created
    	1.0.1 - 
#>

# [CmdletBinding()]

function NIT-Get-IPConfiguration ($IfAliaceTemplate)
{
     Get-NetIPInterface -AddressFamily IPv4 | Where-Object -Property InterfaceAlias -like $IfAliaceTemplate
}

NIT-Get-IPConfiguration ($IfAliaceTemplate)
