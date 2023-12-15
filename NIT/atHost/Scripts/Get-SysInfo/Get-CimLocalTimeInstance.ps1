<#
    .SYNOPSIS
        This Script will Get WMI Local Time Instance
    .DESCRIPTION
        This Script will Get WMI Local Time Instance
    .NOTES
    	File name: Get-CimLocalTimeInstance.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-09-13
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-09-13) Script created
    	1.0.1 - 
#>
Get-CimInstance -ClassName Win32_LocalTime
