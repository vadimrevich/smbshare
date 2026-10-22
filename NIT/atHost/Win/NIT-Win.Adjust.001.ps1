<#
.SYNOPSIS
    This Script Download and Run Some Adjustments
.DESCRIPTION
    This Script Download and Run Some Adjustments
    on Windows 10 Local Computer
.NOTES
    File name: NIT-Win.Adjust.001.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-12-10
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-12-10) Script created
    1.0.1 - 
#>
param([switch]$Elevated)

#### Set Variables

### Add Global Variables

# Set Powershell File

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

$aServerURL="http://win.netip4.ru/Apps/smbshare/NIT/atHost/Win/"
$aLocationPath=$env:TEMP

# Check Integrity
if( !( Test-Path -Path $aLocationPath -PathType Container) ){
    Write-Host "Error! $aLocationPath is not Found"
    Exit 1
}

# Set wc Object
$wc = New-Object System.Net.WebClient

# Set Functions

function NIT-Win-Adjust-001-Download {

    Clear-Host

    $a01File="NIT-NetworkFolders.MpPreference.ps1"
    $a02File="cmdkey-laptop-vg.bat"
    $a03File="cmdkey-win.netip4.ru.bat"
    $a04File="cmdkey-lin.netip4.ru.bat"
    $a05File="cmdkey-raspi.bat"
    $a06File="cmdkey-raspi4.bat"

    $a01URL=$aServerURL+$a01File
    $a02URL=$aServerURL+$a02File
    $a03URL=$aServerURL+$a03File
    $a04URL=$aServerURL+$a04File
    $a05URL=$aServerURL+$a05File
    $a06URL=$aServerURL+$a06File

    $a01Path=Join-Path -Path $aLocationPath -ChildPath $a01File
    $a02Path=Join-Path -Path $aLocationPath -ChildPath $a02File
    $a03Path=Join-Path -Path $aLocationPath -ChildPath $a03File
    $a04Path=Join-Path -Path $aLocationPath -ChildPath $a04File
    $a05Path=Join-Path -Path $aLocationPath -ChildPath $a05File
    $a06Path=Join-Path -Path $aLocationPath -ChildPath $a06File

    # Run Payloads
    $wc.DownloadFile($a01URL, $a01Path)
    $wc.DownloadFile($a02URL, $a02Path)
    $wc.DownloadFile($a03URL, $a03Path)
    $wc.DownloadFile($a04URL, $a04Path)
    $wc.DownloadFile($a05URL, $a05Path)
    $wc.DownloadFile($a06URL, $a06Path)

#    Invoke-WebRequest -Uri $a06URL -OutFile $a06Path

}

function NIT-Win-Adjust-001-Install {

    $a01File="NIT-NetworkFolders.MpPreference.ps1"
    $a02File="cmdkey-laptop-vg.bat"
    $a03File="cmdkey-win.netip4.ru.bat"
    $a04File="cmdkey-lin.netip4.ru.bat"
    $a05File="cmdkey-raspi.bat"
    $a06File="cmdkey-raspi4.bat"

    $a01Path=Join-Path -Path $aLocationPath -ChildPath $a01File
    $a02Path=Join-Path -Path $aLocationPath -ChildPath $a02File
    $a03Path=Join-Path -Path $aLocationPath -ChildPath $a03File
    $a04Path=Join-Path -Path $aLocationPath -ChildPath $a04File
    $a05Path=Join-Path -Path $aLocationPath -ChildPath $a05File
    $a06Path=Join-Path -Path $aLocationPath -ChildPath $a06File

    # Run Payloads

    & $a01Path
    & $a02Path
    & $a03Path
    & $a04Path
    & $a05Path
    & $a06Path
   
}

### Run Payloads

NIT-Win-Adjust-001-Download

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
NIT-Win-Adjust-001-Install
