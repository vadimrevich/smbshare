<#
    .SYNOPSIS
        This Script will Get WMI Firewall Product Instance
    .DESCRIPTION
        This Script will Get WMI Firewall Product Instance
    .NOTES
    	File name: Get-NITWcsFirewallInfo01.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-09-13
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-09-13) Script created
    	1.0.1 - 
#>

## Define a Function
#
function Get-WscFireWallInfo {
[CmdletBinding()]
param (
[parameter(ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
[Alias('name')]
$computername=$env:computername
)
 
$AntiVirusProduct =  gwmi -Namespace root\securitycenter2 -Class FirewallProduct -ComputerName $computername
$ProductState=$AntiVirusProduct.ProductState
#$ProductState
$HexProductState="{0:x6}" -f $ProductState
Write-Verbose "HexProductState=$HexProductState"
 
$ObjHt=@{Computername=$ComputerName; `
        FireWallName=$AntiVirusProduct.displayName; `
        InstanceGuid=$AntiVirusProduct.instanceGuid; `
        PathToSignedProductExe=$AntiVirusProduct.pathToSignedProductExe; `
        PathToSignedReportingExe=$AntiVirusProduct.pathToSignedReportingExe; `
        ProductState=$AntiVirusProduct.productState; `
        HexProductState=$HexProductState; `
        ThirdPartyFirewallPresent=$false;
}
 

New-Object -TypeName PSObject -Property $ObjHt
 
}

## Run a Function
#
Get-WscFireWallInfo
