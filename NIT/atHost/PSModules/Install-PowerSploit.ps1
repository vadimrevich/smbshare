<#
    .SYNOPSIS
        This Script will Install PowerSploit Hacker Tool
    .DESCRIPTION
        This Script will Install PowerSploit Hacker Tool
        on Windows 8.1+ or Windows Server 2012R2+ Computers
        Be Sure that Antivius Exclusions are Set
    .NOTES
    	File name: Install-PowerSploit.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-12-20
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-12-20) Script created
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
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
#       Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Hidden -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

# 'running with full privileges'

# Install PowerSploit
#
Install-Module -Name PowerSploit -RequiredVersion 3.0.0.0 -Force -AllowClobber
