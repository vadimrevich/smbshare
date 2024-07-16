<#
.SYNOPSIS
    This Script will Set a Downloads Shell Folder
    for Windows 10+ Computer
.DESCRIPTION
    This Script will Set a Downloads Shell Folder
.NOTES
    File name: Get-Downloads.w10.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-02-02
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-02-02) Script created
    1.0.1 - 
#>

Function Check-DownloadShellFolder() {
try {
    $DownloadShellFolder=(New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
}
catch {
    Write-Host "Download Shell Folder is not Defined"
    return $false
}

if( !$DownloadShellFolder ) {
    Write-Host "Download Shell Folder is not Defined"
    return $false
}


if( Test-Path $DownloadShellFolder ) {
    Write-Host "Download Shell Folder is $DownloadShellFolder"
    return $true
}
else {
    Write-Host "$DownloadShellFolder is not Found"
    return $false
}
}

### Run a Payload
Check-DownloadShellFolder



