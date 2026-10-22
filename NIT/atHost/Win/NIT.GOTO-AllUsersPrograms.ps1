<#
.SYNOPSIS
    This Script Go To All Users Programs Location
.DESCRIPTION
    This Script Go To All Users Programs Location
    on Windows 10 Local Computer
    This Program Run without Elevatad Privileges
.NOTES
    File name: NIT.GOTO-AllUsersPrograms.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2025-06-12
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2025-06-12) Script created
    1.0.1 - 
#>

#### Set Varianles

### Add Global Variables

$aLocationPath = Join-Path -Path $env:ALLUSERSPROFILE -ChildPath "Microsoft\Windows\Start Menu\Programs"

# Check Integrity
if( !( Test-Path -Path $aLocationPath -PathType Container) ){
    Write-Host "Error! $aLocationPath is not Found"
    Exit 1
}

# Set Functions


### Run Payloads

Set-Location -Path $aLocationPath
