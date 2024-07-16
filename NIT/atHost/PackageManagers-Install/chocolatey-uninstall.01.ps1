<#
    .SYNOPSIS
        This Script will Uninstall Chocolatey Packets Manager
    .DESCRIPTION
        This Script will Uninstall Chocolatey Packets Manager
        on Windows 7/8.1/10/11 or Windows Server 2008R2+ Computers
    .NOTES
    	File name: chocolatey-uninstall.01.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-12-19
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-12-19) Script created
    	1.0.1 - 
#>

if ($env:ChocolateyToolsLocation -and (Test-Path $env:ChocolateyToolsLocation)) {
    Remove-Item -Path $env:ChocolateyToolsLocation -WhatIf -Recurse -Force
}

foreach ($scope in 'User', 'Machine') {
    [Environment]::SetEnvironmentVariable('ChocolateyToolsLocation', [string]::Empty, $scope)
}
