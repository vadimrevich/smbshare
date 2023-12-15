<#
    .SYNOPSIS
        This Script will Check Microsoft Windows OS Check Version
    .DESCRIPTION
        This Script will Check Microsoft Windows OS Check Version
	for further Operations
    .NOTES
    	File name: Get-OSVersion-Environment.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-09-19
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-09-19) Script created
    	1.0.1 - 
#>

# With Help of Class System.Environment

[System.Environment]::OSVersion | Out-Host

# With Help of Class CIM Win32_OperatingSystem
Get-CimInstance Win32_OperatingSystem

# With Help of File systeminfo
# systeminfo.exe /fo csv | ConvertFrom-Csv | Out-Host

# With Help of Commandlet Get-ComputerInfo
# ПРИМЕЧАНИЕ: начиная с 21H1 OsHardwareAbstractionLayer не рекомендуется к использованию
Get-ComputerInfo | Select WindowsProductName, WindowsVersion, OsHardwareAbstractionLayer
