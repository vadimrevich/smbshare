<#
.SYNOPSIS
    This Script will Create an Active Directory
.DESCRIPTION
    This Script will Create an Active Directory
    Forrest with Pointed Parameters at
    Windows Server Machine.
    This Script will automatically Running with Elevated
    Privileges (Restart if not).
.NOTES
    File name: NIT-Create-ADForest.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-08-19
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-08-19) Script created
    1.0.1 - 
#>
param([switch]$Elevated)

### Add Global Variables
$DomainName="nit.local"
$DomainNetbiosName="NIT"

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
#        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

# 'running with full privileges'
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\\Windows\\NTDS" -DomainMode "7" -DomainName $DomainName -DomainNetbiosName $DomainNetbiosName -ForestMode "7" -InstallDns:$true -LogPath "C:\\Windows\\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\\Windows\\SYSVOL" -Force:$true