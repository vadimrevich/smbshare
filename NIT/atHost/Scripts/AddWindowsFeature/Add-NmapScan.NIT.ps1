#Requires -Version 5
<#
.SYNOPSIS
    This Script will install NMap network Scanner
.DESCRIPTION
    This Script will install NMap network Scanners
    This Script Requires Powershell Version 5.0+
.NOTES
    File name: Add-NmapScan.NIT.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2025-08-16
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2025-08-16) Script created
    1.0.1 - 
#>

### Set Variables
#
$chocoBinDir=Join-Path -Path $env:ALLUSERSPROFILE -ChildPath "chocolatey\bin"
$chocoExe = Join-Path -Path $chocoBinDir -ChildPath "choco.exe"

### Set Functions

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

#### Check OS Architecture

if ((Get-WmiObject win32_operatingsystem | select osarchitecture).osarchitecture -like "64*")
{
    #64 bit logic here
    Write-Host "64-bit OS Process"
}
else
{
    #32 bit logic here
    Write-Host "32-bit OS Process"
}

$Is64bitOs = $Is64bit = $env:PROCESSOR_ARCHITECTURE -eq 'AMD64'

if( $Is64bitOs ) {
    Write-Host "64-bit Processor"
}
else
{
    Write-Host "32-bit Processor"
}

$os_type = (Get-WmiObject -Class Win32_ComputerSystem).SystemType -match ‘(x64)’

if ($os_type -eq "True") {
    Write-Host "i am an 64bit OS"
    write-host $os_type 
    $ProgF32 = 'C:\Program Files (x86)'
}
else {
    $os_type = (Get-WmiObject -Class Win32_ComputerSystem).SystemType -match ‘(x86)’

    if ($os_type -eq "True") {
        Write-Host "i am a 32 Bit OS"
        $ProgF32 = 'C:\Program Files'
    } 
}

$nmapEXE = Join-Path -Path $ProgF32 -ChildPath "Nmap\nmap.exe"

### Check Integrity

if( (Test-Path -Path $chocoExe -PathType Leaf) -eq $false ) {
    Write-Host "Error! Chocolatey Packet is not Found"
    Exit 1
}

if( -not (Test-IsAdmin) ) {
    Write-Host "Error! Script must be run with Elevated Privileges"
    Exit 17
}

### Run Payloads

& $chocoExe install -y nmap
if( -not (Test-Path -Path $nmapEXE -PathType Leaf )) {
    Write-Host "$nmapEXE does not exist"
    Exit 1
}
Install-Module -Name PoshNmap

### End
Write-Host "Done Add-NmapScan.NIT.ps1"
Exit 0

