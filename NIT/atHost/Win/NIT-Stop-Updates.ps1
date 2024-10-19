<#
.SYNOPSIS
    This Script will Stop Windows Update
.DESCRIPTION
    This Script will Stop Windows Update
    on Windows 10 Local Computer
.NOTES
    File name: NIT-Stop-Updates.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-09-04
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-09-04) Script created
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

function NIT-Stop-Updates {

    Clear-Host

    $WindowsUpdatePath = "HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\"
    $AutoUpdatePath = "HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"

    If(Test-Path -Path $WindowsUpdatePath) {
        Remove-Item -Path $WindowsUpdatePath -Recurse
    }

    New-Item $WindowsUpdatePath -Force
    New-Item $AutoUpdatePath -Force

    Set-ItemProperty -Path $AutoUpdatePath -Name NoAutoUpdate -Value 1

    Get-ScheduledTask -TaskPath "\Microsoft\Windows\WindowsUpdate\" | Disable-ScheduledTask

    takeown /F C:\Windows\System32\Tasks\Microsoft\Windows\UpdateOrchestrator /A /R
    icacls C:\Windows\System32\Tasks\Microsoft\Windows\UpdateOrchestrator /grant Administrators:F /T

    Get-ScheduledTask -TaskPath "\Microsoft\Windows\UpdateOrchestrator\" | Disable-ScheduledTask

    Stop-Service wuauserv
    Set-Service wuauserv -StartupType Disabled

    # We disable WindowsUpdate folder again, because wuauserv service could have enabled it meanwhile
    Get-ScheduledTask -TaskPath "\Microsoft\Windows\WindowsUpdate\" | Disable-ScheduledTask

    Write-Output "All Windows Updates were disabled"

}

### Run Payloads

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
#        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

# 'running with full privileges'
NIT-Stop-Updates
