param (
   [Parameter (Mandatory=$true,Position=0)]
   [string] $FileName,
   [Parameter (Mandatory=$true, Position=1)]
   [string] $Path
)
<#
.SYNOPSIS
    This Script Find a Full path File Name at File System
.DESCRIPTION
    This Script Find a Full path File Name at File System
    on Windows 10 Local Computer
.NOTES
    File name: NIT.Find-FullFileName.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2025-09-22
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2025-09-22) Script created
    1.0.1 - 
#>

#Requires -Version 5.0  
# Write-Host "I'm version 5.0 or above"

### Functions ###

Function NIT.Find-FullFileName {
    param (
        [Parameter (Mandatory=$true,Position=0)]
        [string] $FileName,
        [Parameter (Mandatory=$true, Position=1)]
        [string] $Path
    )
    
    $aResult = ""
    $aFullFileName = ""
    # Test
    # $aFullFileName = Join-Path -Path $Path -ChildPath $FileName

    $aFullFileName = $(gci -Recurse -Filter $FileName -File -ErrorAction SilentlyContinue -Path $Path | select -First 1).FullName

    if( [string]::IsNullOrEmpty($aFullFileName) -or -not (Test-Path -Path $aFullFileName -PathType Leaf)) {
        $aResult = "none"
    }
    else {
        $aResult = $aFullFileName
    }
    return $aResult
}

$aFile = "Dreamweaver.exe"
$aPath = "C:"

Write-Host (NIT.Find-FullFileName -FileName $FileName -Path $Path)
