<#
    .SYNOPSIS
        This Script will Install Powershell PSGallery
    .DESCRIPTION
        This Script will Install Powershell PSGallery
        on Windows 8.1+ or Windows Server 2012R2+ Computers
        Be Sure that .Net Framework 4.8 is installed
    .NOTES
    	File name: InstallUpdate-PSGallery.ps1
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

# Install TLS12
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

# Install NuGet Package Provider
#
Install-PackageProvider -Name NuGet -Force

# Install PSGallery
#
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -ErrorAction Stop
# Install-Module -Name PowerShellGet -AllowPrerelease -Force
Install-Module -Name PowerShellGet -Force

# Check Installed Modules
Get-InstalledModule PowerShellGet
