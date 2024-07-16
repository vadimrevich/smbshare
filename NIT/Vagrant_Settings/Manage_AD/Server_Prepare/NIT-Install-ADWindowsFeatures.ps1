<#
    .SYNOPSIS
        This Script will Install AD Windows Features
    .DESCRIPTION
        This Script will Install Active Directory Windows Features
        and its Dependences on Windows Server
    .NOTES
    	File name: NIT-Install-ADWindowsFeatures.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2024-01-01
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2024-01-01) Script created
    	1.0.1 - 
#>

### Run a Payload
#
Install-WindowsFeature -Name DNS -IncludeManagementTools -IncludeAllSubFeature
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature

Import-Module ADDSDeployment

Restart-Computer -Force


