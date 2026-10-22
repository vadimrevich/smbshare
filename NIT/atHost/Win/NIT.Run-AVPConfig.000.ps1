<#
.SYNOPSIS
    This Script will Download and Set AVP Settings
.DESCRIPTION
    This Script will Download and Set AVP Settings
    on Windows 10 Local Computer
.NOTES
    File name: NIT.Run-AVPConfig.000.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2025-09-23
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2025-09-23) Script created
    1.0.1 - 
#>

#Requires -Version 5.0  
# Write-Host "I'm version 5.0 or above"

### Functions ###

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

function Get-MyDocumentsShellFolder() {
    $MyDocuments = 5 #System.Environment.SpecialFolder.MyDocuments
    [System.Environment]::GetFolderPath($MyDocuments)
}

function Get-UserProfileShellFolder() {
    if( !$env:USERPROFILE ) {
        return $null
    }
    else {
        $env:USERPROFILE
    }
}


Function Check-MyDocumentsShellFolder() {
    try {
        $DownloadShellFolder=Get-MyDocumentsShellFolder
    }
    catch {
        Write-Host "My Documents Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "My Documents Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "My Documents Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

Function Check-UserProfileShellFolder() {
    try {
        $DownloadShellFolder=Get-UserProfileShellFolder
    }
    catch {
        Write-Host "User Profile Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "User Profile Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "User Profile  Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

Function NIT.Find-FullFileName {
    param (
        [Parameter (Mandatory=$true,Position=0)]
        [string] $FileName,
        [Parameter (Mandatory=$true, Position=1)]
        [string] $Path
    )
    
    $aResult = ""
    $aFullFileName = ""
    # Test
    # $aFullFileName = Join-Path -Path $Path -ChildPath $FileName

    $aFullFileName = $(gci -Recurse -Filter $FileName -File -ErrorAction SilentlyContinue -Path $Path | select -First 1).FullName

    if( [string]::IsNullOrEmpty($aFullFileName) -or -not (Test-Path -Path $aFullFileName -PathType Leaf)) {
        $aResult = "none"
    }
    else {
        $aResult = $aFullFileName
    }
    return $aResult
}

$DownloadsDir = ""
## Set System Objects
$wc = New-Object System.Net.WebClient
if( Check-MyDocumentsShellFolder ) {
    $DownloadsDir = Get-MyDocumentsShellFolder
}
else {
    Write-Host "Check Integrity Error! Download Folder is not Found."
    Exit 1
}

## Set Url and Output
$http_prefix="http"
$http_domain="distrib.netip6.ru"
$http_port="80"
$http_dir000="/Kaspersky/"
$http_suffix="download.php?file="

$aFile = "NIT.Kaspersky.config.cfg"
$aFileName="avp.exe"
$aPath = "C:\"

$anUrl01 = $http_prefix+"://"+$http_domain+":"+$http_port+$http_dir000+$aFile
$anOutput01 = Join-Path -Path $DownloadsDir -ChildPath $aFile

Write-Host $anUrl

if( Test-Path -Path $anOutput01 ) {
    ri -Path $anOutput01 -Force
}

### Run Payloads

$wc.DownloadFile($anUrl01, $anOutput01 )

$ExeFile = ""

$ExeFile = NIT.Find-FullFileName -FileName $aFileName -Path $aPath


if( [string]::IsNullOrEmpty($ExeFile) -or $ExeFile -eq "none" ) {
    Write-Host "Error! File $aFileName is not found."
    Exit 1
}


if ((Test-Admin) -eq $false)  {
    Write-Host "Error! The Script NIT-Win.Adjust.All.001.ps1 is not Run with Elevated Privileges"
    Write-Host "Exit with Code 1"
    Exit 1
}

# 'running with full privileges'

& $ExeFile import $anOutput01

# End
Exit 0
