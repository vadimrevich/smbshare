<#
    .SYNOPSIS
        This Script will Get WMI Logical Disk Instance
    .DESCRIPTION
        This Script will Get WMI Logical Disk Instance
    .NOTES
    	File name: Get-CimLogicalDiskInstance.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-09-13
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-09-13) Script created
    	1.0.1 - 
#>
Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" -Property DeviceID,DriveType,VolumeName,Size,FreeSpace | Select-Object -Property DeviceID,DriveType,VolumeName,Size,FreeSpace | Format-Table
Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | Measure-Object -Property FreeSpace,Size -Sum | Select-Object -Property Property,Sum |Format-Table
