<#
    .SYNOPSIS
        This Script will Install Scoop Packets Manager
    .DESCRIPTION
        This Script will Install Scoop Packets Manager
        on Windows 10/11 or Windows Server 2016+ Computers
    .NOTES
    	File name: scoop-install.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-12-19
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-12-19) Script created
    	1.0.1 - 
#>

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
