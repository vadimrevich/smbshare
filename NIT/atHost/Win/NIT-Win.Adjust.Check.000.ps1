<#
.SYNOPSIS
    This Script Download and Run Some Checks
.DESCRIPTION
    This Script Download and Run Some Checks
    on Windows 10 Local Computer
.NOTES
    File name: NIT-Win.Adjust.Check.000.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2025-04-22
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2025-04-22) Script created
    1.0.1 - 
#>
param([switch]$Elevated)

#### Set Variables

### Add Global Variables

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

$aServerURL="http://file.netip4.ru/PROGS/LIB-RUN/BAT/"
$aLocationPath=$env:TEMP

# Check Integrity
if( !( Test-Path -Path $aLocationPath -PathType Container) ){
    Write-Host "Error! $aLocationPath is not Found"
    Exit 1
}

# Set wc Object
$wc = New-Object System.Net.WebClient

# Set Functions

function NIT-Win-Adjust-Check-000-Download {

    Clear-Host

    $a01File="checkDef.000.cmd"

    $a01URL=$aServerURL+$a01File

    $a01Path=Join-Path -Path $aLocationPath -ChildPath $a01File

    # Run Payloads
    $wc.DownloadFile($a01URL, $a01Path)

#    Invoke-WebRequest -Uri $a06URL -OutFile $a06Path

}

function NIT-Win-Adjust-Check-000-Run {

    $a01File="checkDef.000.cmd"

    $a01Path=Join-Path -Path $aLocationPath -ChildPath $a01File

    # Run Payloads

    & $a01Path

    $aCode = $LASTEXITCODE

    if( ($aCode -eq 0) -or ($aCode -eq 4) -or ($aCode -eq 5)) {
        Write-Host "Success Check Antivirus Executed: Script NIT-Win.Adjust.Check.000"
        Exit 0
    }
    else {
        Write-Host "Error Check Antivirus Executed: Script NIT-Win.Adjust.Check.000"
        Exit 1
    }
   
}

### Run Payloads

& NIT-Win-Adjust-Check-000-Download

if ((Test-Admin) -eq $false)  {
    Write-Host "The Script NIT-Win.Adjust.Check.000 is not Run at Elevated Mode"
    Exit 1
}

# Install WMIC.exe and VBScript
& DISM.exe /Online /Add-Capability /CapabilityName:WMIC~~~~ /NoRestart
& DISM.exe /Online /Add-Capability /CapabilityName:VBSCRIPT~~~~ /NoRestart

# 'running with full privileges'
NIT-Win-Adjust-Check-000-Run
