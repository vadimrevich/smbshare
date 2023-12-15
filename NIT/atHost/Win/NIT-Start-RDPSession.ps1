Param (
[Parameter (Mandatory=$true, Position=1)]
[string]$ComputerName
)

<#
    .SYNOPSIS
        This Script will Start an RDP Session on $computername
    .DESCRIPTION
        This Script will Start an RDP Session on $computername
    .NOTES
    	File name: NIT-Start-RDPSession.ps1
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

function NIT-Start-RDPSession ($ComputerName)
{
    Start-Process "$env:windir\system32\mstsc.exe" -ArgumentList "/v:$computername /admin"
}

NIT-Start-RDPSession($ComputerName)
