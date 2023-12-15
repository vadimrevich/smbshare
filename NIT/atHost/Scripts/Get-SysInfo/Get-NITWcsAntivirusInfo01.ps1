<#
    .SYNOPSIS
        This Script will Get WMI Antivirus Product Instance
    .DESCRIPTION
        This Script will Get WMI Antivirus Product Instance
    .NOTES
    	File name: Get-NITWcsAntivirusInfo01.ps1
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
function Get-WscAntiVirusInfo {
[CmdletBinding()]
param (
[parameter(ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
[Alias('name')]
$computername=$env:computername
)
 
$AntiVirusProduct =  gwmi -Namespace root\securitycenter2 -Class AntiVirusProduct -ComputerName $computername
$ProductState=$AntiVirusProduct.ProductState
#$ProductState
$HexProductState="{0:x6}" -f $ProductState
Write-Verbose "HexProductState=$HexProductState"
 
#$FirstByte = Join-String -Strings "0x", $HexProductState.Substring(0,2)
$FirstByte = -join (“0x”, $HexProductState.Substring(0,2))
 
Write-Verbose "FirstByte=$FirstByte"
$SecondByte = $HexProductState.Substring(2,2)
Write-Verbose "SecondByte=$SecondByte"
$ThirdByte = $HexProductState.Substring(4,2)
Write-Verbose "ThirdByte=$ThirdByte"
 
$ObjHt=@{Computername=$ComputerName; `
        AntivirusName=$AntiVirusProduct.displayName; `
        InstanceGuid=$AntiVirusProduct.instanceGuid; `
        PathToSignedProductExe=$AntiVirusProduct.pathToSignedProductExe; `
        PathToSignedReportingExe=$AntiVirusProduct.pathToSignedReportingExe; `
        ProductState=$AntiVirusProduct.productState; `
        HexProductState=$HexProductState; `
        AntivirusPresent=$false; `
        ThirdPartyFirewallPresent=$false; `
        AutoUpdate=$false; `
        RealTimeProtection=$false; `
        VirusDefsUptoDate=$false}
 
switch ($FirstByte) {
    {($_ -band 1) -gt 0} {$ObjHt.ThirdPartyFirewallPresent=$true}
    {($_ -band 2) -gt 0} {$ObjHt.AutoUpdate=$true}
    {($_ -band 4) -gt 0} {$ObjHt.AntivirusPresent=$true}
}
 
if ($SecondByte -eq "10") {
    $ObjHt.RealTimeProtection=$true
}
 
if ($ThirdByte -eq "00") {
    $ObjHt.VirusDefsUptoDate=$true
}
 
New-Object -TypeName PSObject -Property $ObjHt
 
}

## Run a Function
#
Get-WscAntiVirusInfo

