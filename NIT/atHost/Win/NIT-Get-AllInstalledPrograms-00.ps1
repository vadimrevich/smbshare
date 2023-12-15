<#
    .SYNOPSIS
        This Script will Get Information about Installed Programs
    .DESCRIPTION
        This Script will Get Information about Installed Programs
    .NOTES
    	File name: NIT-Get-AllInstalledPrograms-00.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-11-15
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-11-15) Script created
    	1.0.1 - 
#>

function NIT-Get-AllInstalledPrograms()
{
	# Get a List of Installed Programs
	$all_programs = Get-ChildItem -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\'
	# Filter of Results
	$all_programs = $all_programs | Get-ItemProperty | `
                Where-Object 'DisplayName' | `
                Select 'DisplayName','DisplayVersion' | `
                Sort-Object -Property 'DisplayName'
	$all_programs
}

NIT-Get-AllInstalledPrograms
