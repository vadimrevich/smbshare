param (
   [Parameter (Mandatory=$false,Position=0)]
   [string] $IPAddr
)
<#
.SYNOPSIS
    This Script will Get Windows Computer Host Name
.DESCRIPTION
    This Script will Get Windows Computer Host Name
    from IP Address
.NOTES
    File name: NIT.Get-HostName.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2026-02-19
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2026-02-19) Script created
    1.0.1 - 
#>

###########################################################
# NIT.Get-HostName.ps1
# This Script will Get Windows Computer Host Name
# from IP Address
#
###########################################################

# Set Variables

# Set Functions

function DNSResolve {
    param (
        [Parameter (Mandatory=$true,Position=0)]
        [string] $IPAddr
    )
    $Name = Resolve-DnsName -Type PTR -Name $IPAddr | Select-Object -ExpandProperty NameHost
    if( [string]::IsNullOrEmpty($Name) ){
        $Name = ""
    }
    return $Name
}

function GetHostByAddress {
    param (
        [Parameter (Mandatory=$true,Position=0)]
        [string] $IPAddr
    )
    $hostName = ""
    $hostEntry = [System.Net.Dns]::GetHostByAddress($IPAddr)
    if( $hostEntry ) {
        $hostName = $hostEntry.HostName
    }
    return $hostName
}

function GetWMIHost {
    param (
        [Parameter (Mandatory=$true,Position=0)]
        [string] $IPAddr
    )
    $Name = ""
    try {
        $Name = $(Get-WmiObject -Class Win32_ComputerSystem -ComputerName $IPAddr).Name
    }
    catch {
        $Name = ""
    }
    if( [string]::IsNullOrEmpty($Name) ){
        $Name = ""
    }
    return $Name
}

function GetObject {
    param (
        [Parameter (Mandatory=$false,Position=0)]
        [string] $IPAddr
    )
    if( [string]::IsNullOrEmpty($IPAddr)){
        $IPAddr = "127.0.0.1"
    }
    $DNSResolve = $(DNSResolve $IPAddr | Select-Object -First 1 )
    $DNSByAddr = GetHostByAddress $IPAddr
    $WMIHost = GetWMIHost $IPAddr
    $anObject = New-Object  -TypeName PSCustomObject -Property @{ DNSResolve = ${DNSResolve}; DNSByAddr = ${DNSByAddr}; WMIHost = ${WMIHost} }
    return $anObject
}

GetObject $IPAddr
