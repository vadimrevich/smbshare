<#
    .SYNOPSIS
        This Script will Install PS WindowsUpdate Module
    .DESCRIPTION
        This Script will Install a Windows Powershell
	Windows Update Module for a same Procedure
    .NOTES
    	File name: NIT-ToInstall-PSWindowsUpdate.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-08-01
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-08-01) Script created
    	1.0.1 - 
#>
Find-PackageProvider
Install-Package PowershellGet -Force -Verbose
Install-Module -Name PSWindowsUpdate -Force -Verbose -AllowClobber

