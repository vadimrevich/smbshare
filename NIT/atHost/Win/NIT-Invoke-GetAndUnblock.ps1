param (
    [parameter(Mandatory=$true,position=1)]
    [string] $Url,
    [parameter(Mandatory=$true, position=2)]
    [string] $OutFile
)
<#
.SYNOPSIS
    This Script will Get File and Unblock
.DESCRIPTION
    This Script will Get a File from Internet
    to Local Computer.and Unblock it
.NOTES
    File name: NIT-Invoke-GetAndUnblock.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-08-29
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-8-29) Script created
    1.0.1 - 
#>
# param([switch]$Elevated)

# Set Functions

function NIT-Invoke-GetAndUnblock {
    
    param (
        [parameter(Mandatory=$true,position=1)]
        [string] $Url,
        [parameter(Mandatory=$true, position=2)]
        [string] $OutFile
    )
    if( (iwr -Uri $Url).StatusCode -ne 200 ) {
        Write-Host "Error! Uri $Url is not valid"
    }
    else {
        iwr -Uri $Url -OutFile $OutFile
        Unblock-File $OutFile
        Write-Host "Script $PSCommandPath is executed with Success"
    }
}

# Run Payloads
NIT-Invoke-GetAndUnblock $Url $OutFile
