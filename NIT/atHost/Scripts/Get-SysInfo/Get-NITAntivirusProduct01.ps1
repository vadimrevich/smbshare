<#
    .SYNOPSIS
        This Script will Get WMI Antivirus Product Instance
    .DESCRIPTION
        This Script will Get WMI Antivirus Product Instance
    .NOTES
    	File name: Get-NITAntivirusProduct01.ps1
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
function Get-AntiVirusProduct {
    [CmdletBinding()]
    param (
    [parameter(ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('name')]
    $computername=$env:computername


    )

    #$AntivirusProducts = Get-WmiObject -Namespace "root\SecurityCenter2" -Query $wmiQuery  @psboundparameters # -ErrorVariable myError -ErrorAction 'SilentlyContinue' # did not work            
     $AntiVirusProducts = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct  -ComputerName $computername

    $ret = @()
    foreach($AntiVirusProduct in $AntiVirusProducts){
        #Switch to determine the status of antivirus definitions and real-time protection.
        #The values in this switch-statement are retrieved from the following website: http://community.kaseya.com/resources/m/knowexch/1020.aspx
        switch ($AntiVirusProduct.productState) {
        "262144" {$defstatus = "Up to date" ;$rtstatus = "Disabled"}
            "262160" {$defstatus = "Out of date" ;$rtstatus = "Disabled"}
            "266240" {$defstatus = "Up to date" ;$rtstatus = "Enabled"}
            "266256" {$defstatus = "Out of date" ;$rtstatus = "Enabled"}
            "393216" {$defstatus = "Up to date" ;$rtstatus = "Disabled"}
            "393232" {$defstatus = "Out of date" ;$rtstatus = "Disabled"}
            "393488" {$defstatus = "Out of date" ;$rtstatus = "Disabled"}
            "397312" {$defstatus = "Up to date" ;$rtstatus = "Enabled"}
            "397328" {$defstatus = "Out of date" ;$rtstatus = "Enabled"}
            "397584" {$defstatus = "Out of date" ;$rtstatus = "Enabled"}
        default {$defstatus = "Unknown" ;$rtstatus = "Unknown"}
            }

        #Create hash-table for each computer
        $ht = @{}
        $ht.Computername = $computername
        $ht.Name = $AntiVirusProduct.displayName
        $ht.'Product GUID' = $AntiVirusProduct.instanceGuid
        $ht.'Product Executable' = $AntiVirusProduct.pathToSignedProductExe
        $ht.'Reporting Exe' = $AntiVirusProduct.pathToSignedReportingExe
        $ht.'Definition Status' = $defstatus
        $ht.'Real-time Protection Status' = $rtstatus


        #Create a new object for each computer
        $ret += New-Object -TypeName PSObject -Property $ht 
    }
    Return $ret
} 

## Start a Function
#
Get-AntiVirusProduct
