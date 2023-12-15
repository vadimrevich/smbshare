<#
.SYNOPSIS
    This Script will Interactive Install Modules for NTLM
    Hash Extract for Local Computer.
    This Script will automatically Running with Elevated
    Privileges (Restart if not).
.DESCRIPTION
    This Script will Install Modules for NTLM Hash Extract (Interactive)
.NOTES
    File name: NIT-Install-ModulesForWinCred.ps1
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
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
#        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

# 'running with full privileges'
# Help String
Write-Host "Please Press 'A' Key for All Questions"
Write-Host "Пожалуйста нажмите латинскую 'A' при всех вопросах"

# Install an ImpersonateSystem Module
Install-Module -Name ImpersonateSystem -Force

# Install a NTLMX Module
Install-Module -Name NTLMX -Force

# Check if Module Installed
Write-Host "You must see a 'СИСТЕМА' Output"
Write-Host "Вы должны увидеть вывод СИСТЕМА"
Import-Module ImpersonateSystem
Invoke-AsSystem { [System.Environment]::UserName }
