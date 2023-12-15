<#
    .SYNOPSIS
        This Script will Get Information about local Computer
    .DESCRIPTION
        This Script will Get Information about local Computer
    .NOTES
    	File name: NIT-Get-ComputerInfo-w10-00.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-11-15
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-11-15) Script created
    	1.0.1 - 
#>

function NIT-Get-ComputerInfo()
{
    Write-Host "Check OS Version"
    [System.Environment]::OSVersion.Version
    Write-Host "Get Information abaot PS Version"
    $PSVersionTable
    Write-Host "Get Host Information"
    Get-Host
    Write-Host "Information about Desktop"
	Get-CimInstance -ClassName Win32_Desktop | Select-Object -ExcludeProperty "CIM*"
    Write-Host "Information about BIOS"
	Get-CimInstance -ClassName Win32_BIOS
    Write-Host "Information about Processor"
	Get-CimInstance -ClassName Win32_Processor | Select-Object -ExcludeProperty "CIM*"
    Write-Host "Information about System Type"
	Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property SystemType
    Write-Host "Information about Computer System"
	Get-CimInstance -ClassName Win32_ComputerSystem
    Write-Host "Information about Hotfix"
	Get-CimInstance -ClassName Win32_QuickFixEngineering -Property HotFixId | Select-Object -Property HotFixId
    Write-Host "Main Information about Operation System"
	Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property Build*,OSType,ServicePack*
    Write-Host "Information about Licensed Users"
	Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property NumberOfLicensedUsers, NumberOfUsers, RegisteredUser
    Write-Host "Information about Hard Disks"
	Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"
    Write-Host "Information about Disks Size and Free Spaca"
	Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | Measure-Object -Property FreeSpace,Size -Sum | Select-Object -Property Property,Sum
    Write-Host "Information about Logon Sessions"
	Get-CimInstance -ClassName Win32_LogonSession
    Write-Host "Information about Logined Users"
	Get-CimInstance -ClassName Win32_ComputerSystem -Property UserName
    # Write-Host "Information adout Sustem Services"
	# Get-CimInstance -ClassName Win32_Service | Format-Table -Property Status, Name, DisplayName -AutoSize -Wrap
}

NIT-Get-ComputerInfo
