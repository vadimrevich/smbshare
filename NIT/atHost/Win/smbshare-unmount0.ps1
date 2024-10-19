<#
.SYNOPSIS
    This Script Deletes local share smbmount0 and
    all Local Files on It
.DESCRIPTION
    This Script Deletes Local Settings Script Share
.NOTES
    File name: smbshare-unmount0.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2023-03-18
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2023-03-18) Script created
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

$SMBSHARE="smbshare"
$WINSMBSHARE0="smbshare"

### Check System Conditions
#
$isAdmin = Test-IsAdmin

### Run Algorythm

if( $isAdmin ){

### === Script body === ###

Remove-SmbShare -Name $WINSMBSHARE0  -Confirm:$false
Remove-Item -Path C:\.BIN\$SMBSHARE -Recurse -Force -Confirm:$false

### === End Script Body === ###

    Write-Host Successful Script Run!
    # return 0
}
else {
	Write-Host Warning! Script must be Run with Elevated Privileges!
	# return 17;
}
