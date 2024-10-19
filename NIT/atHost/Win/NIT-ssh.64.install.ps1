<#
.SYNOPSIS
    This Script will Install OpenSSH
.DESCRIPTION
    This Script will Install OpenSSH
    client and server at
    Windows Machine.
    This Script will automatically Running with Elevated
    Privileges (Restart if not).
.NOTES
    File name: NIT-ssh.64.install.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-08-23
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-08-23) Script created
    1.0.1 - 
#>
param([switch]$Elevated)

### Add Global Variables

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

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
$ScriptPath = Join-Path -Path $env:ProgramFiles -ChildPath "OpenSSH-Win64\install-sshd.ps1"


&choco.exe install -y openssh
& $ScriptPath
Remove-NetFirewallRule -DisplayName "OpenSSH Server allow"
Remove-NetFirewallRule -DisplayName "OpenSSH Client allow"
New-NetFirewallRule -DisplayName "OpenSSH Server allow" `
    -Description "OpenSSH Server allow" -Profile @('Domain', 'Private', 'Public') `
    -Direction Inbound -Action Allow -Program "C:\Program Files\OpenSSH-Win64\sshd.exe" `
    -Enabled True
New-NetFirewallRule -DisplayName "OpenSSH Client allow" `
    -Description "OpenSSH Client allow" -Profile @('Domain', 'Private', 'Public') `
    -Direction Inbound -Action Allow -Program "C:\Program Files\OpenSSH-Win64\ssh.exe" `
    -Enabled True
Set-Service -Name "ssh-agent" -StartupType Automatic -Status Running
Set-Service -Name "sshd" -StartupType Automatic -Status Running
