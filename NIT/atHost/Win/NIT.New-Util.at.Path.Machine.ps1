<#
.SYNOPSIS
    This Script Add path C:\Util into System Path Variable
.DESCRIPTION
    This Script Add path C:\Util into System Path Variable
    on Windows Local Computer
.NOTES
    File name: NIT.New-Util.at.Path.Machine.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2025-07-15
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2025-07-15) Script created
    1.0.1 - 
#>
param([switch]$Elevated)

#### Set Varianles

### Add Global Variables

$MyPath = $env:UTIL
# $MyPath = 'C:\Util'

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function New-AtMachinePath (
	[string]$my_path
)
{
	$PATH = [Environment]::GetEnvironmentVariable("PATH")
	if([string]::IsNullOrEmpty($PATH) -eq $true -or [string]::IsNullOrEmpty($my_path)) {
        Write-Host "A Variable `$PATH or `$my_path is empty"
        return 1
    }
    [Environment]::SetEnvironmentVariable("PATH", "$PATH;$my_path", "Machine")
    Write-Host "Succes adding Path $my_path at the `$PATH variable"
    return 0
}


# Run Payload

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

$iRes = New-AtMachinePath -my_path $MyPath

