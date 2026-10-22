<#
.SYNOPSIS
    This Script will Check Antivirus to be Installed
.DESCRIPTION
    This Script will Check Antivirus to be Installed
    at the Windows Operation System
.NOTES
    File name: NIT.Check.AV.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2025-03-04
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2025-03-04) Script created
    1.0.1 - 
#>

### Define System Function

function Test-IsAdmin {
    try {
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal -ArgumentList $identity
        return $principal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )
    } catch {
        throw "Failed to determine if the current user has elevated privileges. The error was: '{0}'." -f $_
    }
}

# *******************************************************
# smbshare-unmount0.ps1
# This Script Deletes local share smbmount0 and
# all Local Files on It
# *******************************************************

# Code for Self Elevated Script

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

# Your script here

$BATFileName="check.av.wmic.cmd"
# PowerShell v2
$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$BATFullName = Join-Path -Path $PSScriptRoot -ChildPath $BATFileName

### Check System Conditions
#
$isAdmin = Test-IsAdmin

### Run Algorythm

if( $isAdmin ){

### === Script body === ###

    $AV = & $BATFullName
    $AV = $AV -replace '(^\s+|\s+$)','' -replace '\s+',' '
    if( $AV -eq "Windows Defender" ) {
        Write-Host "The default antivirus $AV is installed"
        exit 1
    }
    if( $AV -eq "No Antivirus installed") {
        Write-Host $AV
        exit 0
    }

    Write-Host "The third-party Antivirus $AV is installed"
    exit 2
### === End Script Body === ###

}
else {
	Write-Host Warning! Script must be Run with Elevated Privileges!
	exit 17;
}
