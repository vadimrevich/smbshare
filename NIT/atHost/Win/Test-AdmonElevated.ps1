<#
.SYNOPSIS
    This Script will Test if Console has been run Elevated
.DESCRIPTION
    This Script will Test if Console has been run Elevated
.NOTES
    File name: Test-AdminElevated.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-02-20
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-02-20) Script created
    1.0.1 - 
#>

[bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
