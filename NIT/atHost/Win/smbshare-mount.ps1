<#
.SYNOPSIS
    This Script Mounts X: a Drive with \\WIN\smbshare,
    Copies it at a Local System and Prepares smbshare0
.DESCRIPTION
    This function is Prepare a Setting Share on Target System
.NOTES
    File name: smbshare-mount.ps1
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
# smbshare-mount.ps1
# This Script Mounts X: a Drive with \\WIN\smbshare,
# Copies it at a Local System and Prepares smbshare0
# *******************************************************

# Code for Self Elevated Script

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

# Your script here

$SMBSHARE="smbshare"
$WINUNC="WIN.netip4.ru"
$WINUSER="WIN\MSSQLSR"
$WINPASS="Admin01234"
$WINSMBSHARE0="smbshare"

### Check System Conditions
#
$isAdmin = Test-IsAdmin

### Run Algorythm

if( $isAdmin ){

### === Script body === ###

&md C:\.BIN
&md C:\.BIN\$SMBSHARE
# cd C:\.BIN\$SMBSHARE
&net.exe USE /PERSISTENT:No
## &cmdkey.exe /ADD:$WINUNC /USER:$WINUSER /PASS:$WINPASS
&net.exe USE X: \\$WINUNC\$SMBSHARE $WINPASS /USER:$WINUSER
&xcopy.exe x:\*.* C:\.BIN\$SMBSHARE\ /S /E /v /Y /r /h /z
&net.exe USE X: /DELETE
##&net.exe SHARE smbshare0=C:\.BIN\smbshare /UNLIMITED /REMARK:"Smb Share for Config"
New-SmbShare -Name $WINSMBSHARE0 -Path C:\.BIN\$SMBSHARE -FullAccess *S-1-1-0 -Description "Smb Share for Config"
$ScriptACL = Join-Path -Path $PSScriptRoot -ChildPath "Set-ScriptAcl-003.ps1"
iex $ScriptACL
## &net.exe SHARE smbshare0 \\localhost /Delete

### === End Script Body === ###

    Write-Host Successful Script Run!
    # return 0
}
else {
	Write-Host Warning! Script must be Run with Elevated Privileges!
	# return 17;
}
