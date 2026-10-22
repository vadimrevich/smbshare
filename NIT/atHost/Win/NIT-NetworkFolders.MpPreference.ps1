<#
.SYNOPSIS
    This Script Add Windows Defender Exclusions
.DESCRIPTION
    This Script will Add Windows Defender Exclusions
    for Network Folders
    on Windows 10 Local Computer
.NOTES
    File name: NIT-NetworkFolders.MpPreference.ps1
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

#### Set Varianles

### Add Global Variables

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# Set Functions

function NIT-NetworkFolders-MpPreference {

    Clear-Host

    $a01Path="D:\yuden"
    $a02Path="D:\$RECYCLE.BIN"
    $a03Path="D:\OneDriveTemp"
    $a04Path="\\KEENETIC-9335\opkg"
    $a05Path="\\lin.netip4.ru\vagrant"
    $a06Path="\\lin.netip4.ru\srv"
    $a07Path="\\win.netip4.ru\c$"
    $a08Path="\\win.netip4.ru\smbshare"
    $a09Path="\\win.netip4.ru\TOWIN"
    $a10Path="x:\"
    $a11Path="z:\"
    $a12Path="\\RASPBERRYPI4\srv"
    $a13Path="\\RASPBERRYPI4\vagrant"
    $a14Path="\\RASPBERRYPI\pi"
    $a15Path="\\RASPBERRYPI\srv"
    $a16Path="\\192.168.252.5\srv"
    $a17Path="\\192.168.252.5\vagrant"
    $a18Path="\\192.168.252.4\pi"
    $a19Path="\\192.168.252.4\srv"
    $a20Path="\\win.netip4.ru\NETIP\Zlovred"
    $a21Path="C:\NETIP\Zlovred"

    # Run Payloads
    Add-MpPreference -ExclusionPath $a01Path
    Add-MpPreference -ExclusionPath $a02Path
    Add-MpPreference -ExclusionPath $a03Path
    Add-MpPreference -ExclusionPath $a04Path
    Add-MpPreference -ExclusionPath $a05Path
    Add-MpPreference -ExclusionPath $a06Path
    Add-MpPreference -ExclusionPath $a07Path
    Add-MpPreference -ExclusionPath $a08Path
    Add-MpPreference -ExclusionPath $a09Path
    Add-MpPreference -ExclusionPath $a10Path
    Add-MpPreference -ExclusionPath $a11Path
    Add-MpPreference -ExclusionPath $a12Path
    Add-MpPreference -ExclusionPath $a13Path
    Add-MpPreference -ExclusionPath $a14Path
    Add-MpPreference -ExclusionPath $a15Path
    Add-MpPreference -ExclusionPath $a16Path
    Add-MpPreference -ExclusionPath $a17Path
    Add-MpPreference -ExclusionPath $a18Path
    Add-MpPreference -ExclusionPath $a19Path
    Add-MpPreference -ExclusionPath $a20Path
    Add-MpPreference -ExclusionPath $a21Path

}

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
NIT-NetworkFolders-MpPreference
