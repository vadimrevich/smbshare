<#
.SYNOPSIS
    This Script will Unblock Downloaded Files
.DESCRIPTION
    This Script will Unblock Downloaded Files
    from Local Computer
    at Directories Download, Documents, Desktop and UserProfile
.NOTES
    File name: NIT-UnblockFiles.ps1
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
#Requires -Version 3.0  
Write-Host "I'm version 3.0 or above"

# Set Variables

$MyDownloads = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$MyDocuments = [Environment]::GetFolderPath("MyDocuments")
$MyDesktop = [Environment]::GetFolderPath("Desktop")

Write-Host "My Documents = $MyDocuments"
Write-Host "My Desktop  = $MyDesktop"
Write-Host "My Downloads = $MyDownloads"
Write-Host "My Profile = $env:USERPROFILE"

# Run Payloads

gci $env:USERPROFILE | Unblock-File
gci $MyDownloads -Recurse | Unblock-File
gci $MyDesktop -Recurse | Unblock-File
gci $MyDocuments -Recurse | Unblock-File

