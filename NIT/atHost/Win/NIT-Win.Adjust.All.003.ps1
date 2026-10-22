<#
.SYNOPSIS
    This Script Download and Run Some Adjustments
.DESCRIPTION
    This Script Download and Run Some Adjustments
    on Windows 10 Local Computer
.NOTES
    File name: NIT-Win.Adjust.All.003.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2025-04-12
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2025-04-12) Script created
    1.0.1 - 
#>
param([switch]$Elevated)

#### Set Variables

### Add Global Variables

$anUrl001 = "http://win.netip4.ru/Apps/smbshare/NIT/atHost/Win/DownloadFile.ashx?file=NIT-Win.Adjust.000_1.ps1"
$anUrl002 = "http://win.netip4.ru/Apps/smbshare/NIT/atHost/Win/DownloadFile.ashx?file=NIT-Win.Adjust.001.ps1"
$anUrl003 = "http://file.netip4.ru/PROGS/NIT/RunFromFolderSchedule/download.php?file=RunFromFolderSchedule.installscripts.ps1"
$anUrl004 = "http://win.netip4.ru/Apps/smbshare/NIT/atHost/Win/DownloadFile.ashx?file=smbshare-mount.ps1"
$anUrl005 = "http://win.netip4.ru/Apps/smbshare/NIT/atHost/Win/DownloadFile.ashx?file=smbshare-unmount0.ps1"
$anUrl006 = "https://github.com/massgravel/Microsoft-Activation-Scripts/archive/refs/heads/master.zip"
$anUrl007 = "http://file.netip4.ru/PROGS/NIT/NIT.Set-UserPosh.Unrestricted/download.php?file=NIT.RunScheduled.00.ps1"
# $anUrl008 = "http://win.netip4.ru/Apps/smbshare/NIT/atHost/Win/DownloadFile.ashx?file=NIT-Win.Adjust.Check.000.ps1"

### Set Functions
#

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

### Set Functions
#

Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

## Set System Objects
$wc = New-Object System.Net.WebClient
if( Check-DownloadShellFolder ) {
    $DownloadsDir = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
}
else {
    Write-Host "Check Integrity Error! Download Folder is not Found."
    Exit 1
}

## Set Url and Output
#

$anOutput01 = Join-Path -Path $DownloadsDir -ChildPath "NIT-Win.Adjust.003_1.ps1"
$anOutput02 = Join-Path -Path $DownloadsDir -ChildPath "NIT-Win.Adjust.003.ps1"
$anOutput03 = Join-Path -Path $DownloadsDir -ChildPath "RunFromFolderSchedule.installscripts.ps1"
$anOutput04 = Join-Path -Path $DownloadsDir -ChildPath "smbshare-mount.ps1"
$anOutput05 = Join-Path -Path $DownloadsDir -ChildPath "smbshare-unmount0.ps1"
$anOutput06 = Join-Path -Path $DownloadsDir -ChildPath "massgrave.zip"
$anOutput07 = Join-Path -Path $DownloadsDir -ChildPath "NIT.RunScheduled.00.ps1"
# $anOutput08 = Join-Path -Path $DownloadsDir -ChildPath "NIT-Win.Adjust.Check.000.ps1"

if( Test-Path -Path $anOutput01 ) {
    ri -Path $anOutput01 -Force
}

if( Test-Path -Path $anOutput02 ) {
    ri -Path $anOutput02 -Force
}

if( Test-Path -Path $anOutput03 ) {
    ri -Path $anOutput03 -Force
}

if( Test-Path -Path $anOutput04 ) {
    ri -Path $anOutput04 -Force
}

if( Test-Path -Path $anOutput05 ) {
    ri -Path $anOutput05 -Force
}

if( Test-Path -Path $anOutput06 ) {
    ri -Path $anOutput06 -Force
}

if( Test-Path -Path $anOutput07 ) {
    ri -Path $anOutput07 -Force
}

if( Test-Path -Path $anOutput08 ) {
    ri -Path $anOutput08 -Force
}

### Run Payloads

if ((Test-Admin) -eq $false)  {
    Write-Host "Error! The Script NIT-Win.Adjust.All.003.ps1 is not Run with Elevated Privileges"
    Write-Host "Exit with Code 1"
    Exit 1
}

# 'running with full privileges'

# Install WMIC.exe and VBScript
& DISM.exe /Online /Add-Capability /CapabilityName:WMIC~~~~ /NoRestart
& DISM.exe /Online /Add-Capability /CapabilityName:VBSCRIPT~~~~ /NoRestart

### Check Antivirus
##
# $wc.DownloadFile($anUrl008, $anOutput08)
#& $anOutput08
# if( $LASTEXITCODE -ne 0 ) {
    # Write-Host "Eroor! The Installed Aintivirus can be Windows Defender or Antivirus are not Installed"
    # Write-Host "Exit with Code 1"
    # Exit 1
#}
# else {
    # Write-Host "Success Check Antivirus to be Installed"
# }

### Download and Run Payloads

$wc.DownloadFile($anUrl001, $anOutput01)
& $anOutput01
$wc.DownloadFile($anUrl002, $anOutput02)
& $anOutput02
$wc.DownloadFile($anUrl003, $anOutput03)
# & $anOutput03
$wc.DownloadFile($anUrl004, $anOutput04)
# & $anOutput04
$wc.DownloadFile($anUrl005, $anOutput05)
## & $anOutput05
$wc.DownloadFile($anUrl006, $anOutput06)
## & $anOutput06
$wc.DownloadFile($anUrl007, $anOutput07)
# & $anOutput07

### Decompress an Massgrave Archive
Unzip "$anOutput06", "$DownloadsDir"

### The End of the Script ###
#
Write-Host "Script is successfully executed"
exit 0

