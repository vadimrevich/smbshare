<#
.SYNOPSIS
    This function sets PSGallery Repository 
    Trusted at Windows Machine
.DESCRIPTION
    This script will set PSGallery Trusted at Windows Machine
.NOTES
    File name: Set-PSGallery.Trusted.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2023-07-15
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2023-07-15) Script created
    1.0.1 - 
#>

Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
# Set-PackageSource -Name chocolatey -Trusted

