<#
.SYNOPSIS
    This Script will Get a FQDN Name
    for Local Computer.
.DESCRIPTION
    This Script will Get a FQDN Name
.NOTES
    File name: Get-SameFQDN-Name.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-07-24
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-07-24) Script created
    1.0.1 - 
#>

# Run Payload
return [System.Net.Dns]::GetHostByName($env:computername).HostName
