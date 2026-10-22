<#
.SYNOPSIS
    This Script will CleanUp Fresh Windows 11 Installing
.DESCRIPTION
    This Script will CleanUP Fresh Windows 11 Installing
    It will Delete Restore Points, Temprorary Files, etc.
.NOTES
    File name: NIT.Cleanup-Image.Win11.00.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2026-05-09
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2026-05-09) Script created
    1.0.1 - 
#>

###########################################################
# NIT.Cleanup-Image.Win11.00.ps1
# This Script will Clean Up Fresh Windows 11 Installing
# 
#
###########################################################
# param([switch]$Elevated)

# Set Variables

$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Set Functions

function Get-MyDocumentsShellFolder() {
    $MyDocuments = 5 #System.Environment.SpecialFolder.MyDocuments
    [System.Environment]::GetFolderPath($MyDocuments)
}

function Get-MyVideoFolder(){
    $MyVideo = 14 #System.Environment.SpecialFolder.MyVideo
    [System.Environment]::GetFolderPath($MyVideo)
}

function Get-MyPicturesFolder(){
    $MyPictures = 39 #System.Environment.SpecialFolder.MyVideo
    [System.Environment]::GetFolderPath($MyPictures)
}

function Get-MyMusicFolder(){
    $MyMusic = 13 #System.Environment.SpecialFolder.MyVideo
    [System.Environment]::GetFolderPath($MyMusic)
}

function Get-UserProfileShellFolder() {
    if( !$env:USERPROFILE ) {
        return $null
    }
    else {
        $env:USERPROFILE
    }
}

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

### Set Auxiliary Script
$Script000Name="CleanupUserProfile.ps1"
$Script001Name="NIT.Remove-DefMetroApps.00.ps1"

$Script000Path = Join-Path -Path $scriptDirectory -ChildPath $Script000Name
$Script001Path = Join-Path -Path $scriptDirectory -ChildPath $Script001Name



function Delete-Cleanup-00 {

    # Remove Predefined Metro Applications
    if( Test-Path -Path $Script001Path -PathType  ) {
        & $Script001Path
    }

    # Remove Shadow Copies
    vssadmin delete shadows /All /Quiet

    # Clean Up Windows Updates and Components
    Dism.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase
    del %windir%\SoftwareDistribution\Download\*.* /f /s /q

    # Clear User Cache and Downloads
    if( Test-Path -Path $Script000Path -PathType  ) {
        & $Script000Path
    }

    # Clean With CleanMgr
    & Cleanmgr /sagerun:1

    for /F "tokens=*" %1 in ('wevtutil.exe el') DO wevtutil.exe cl "%1"

    # Clean Recycle Bin
    Clear-RecycleBin -Force
}

### Run Payloads

#if ((Test-Admin) -eq $false)  {
#    if ($elevated) {
#        # tried to elevate, did not work, aborting
#    } else {
##        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
#        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    #}
    #exit
#}

# 'running with full privileges'

# Delete-Cleanup-00
