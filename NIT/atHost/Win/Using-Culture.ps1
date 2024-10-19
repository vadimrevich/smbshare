Param (
[Parameter (Mandatory=$true, Position=1)]
[string]$culture,
[Parameter (Mandatory=$true, Position=2)]
[ScriptBlock]$Script
)

<#
.SYNOPSIS
    Using a New Culture for PowerShell Scripts
.DESCRIPTION
    Using a New Culture for PowerShell Scripts
    on Windows 10.0 Local Computer
.NOTES
    File name: Using-Culture.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-10-08
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-10-08) Script created
    1.0.1 - 
#>

### Set Variables
#


### Set a Function
#

function Using-Culture (
  [System.Globalization.CultureInfo]
  $culture = (throw "USAGE: Using-Culture -Culture culture -Script {...}"),
  [ScriptBlock]
  $script = (throw "USAGE: Using-Culture -Culture culture -Script {...}"))
{
    $OldCulture = [Threading.Thread]::CurrentThread.CurrentCulture
    $OldUICulture = [Threading.Thread]::CurrentThread.CurrentUICulture
    try {
        [Threading.Thread]::CurrentThread.CurrentCulture = $culture
        [Threading.Thread]::CurrentThread.CurrentUICulture = $culture
        Invoke-Command $script
    }
    finally {
        [Threading.Thread]::CurrentThread.CurrentCulture = $OldCulture
        [Threading.Thread]::CurrentThread.CurrentUICulture = $OldUICulture
    }
}

### Run Payloads
#

Using-Culture -culture $culture -script $Script
