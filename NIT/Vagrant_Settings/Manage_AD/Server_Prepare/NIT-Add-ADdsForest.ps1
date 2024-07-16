<#
    .SYNOPSIS
        This Script will Install AD Windows Features
    .DESCRIPTION
        This Script will Install Active Directory Windows Features
        and its Dependences on Windows Server
    .NOTES
    	File name: NIT-Add-ADdsForest.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2024-01-01
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2024-01-01) Script created
    	1.0.1 - 
#>

### Set Variables
#

### Run a Payload
#
$ForrestDomainName="peter.yuden.local"
$NetBiosDomainName="PETER"
$LogPath=Join-Path -Path $env:SystemRoot -ChildPath "NTTDS"
$DatabasePath=Join-Path -Path $env:SystemRoot -ChildPath "NTTDS"
$SysVolPath=Join-Path -Path $env:SystemRoot -ChildPath "SYSVOL"
$ServerMode="Win2012R2"
$SafePassword="0A9s8d7F"

Install-ADDSForest `
 -CreateDnsDelegation:$false `
 -DatabasePath $DatabasePath `
 -DomainMode $ServerMode `
 -DomainName $ForrestDomainName `
 -DomainNetbiosName $NetBiosDomainName `
 -ForestMode $ServerMode `
 -InstallDns:$true `
 -LogPath $LogPath `
 -NoRebootOnCompletion:$false `
 -SysvolPath SysVolPath `
 -SafeModeAdministratorPassword (ConvertTo-SecureString $SafePassword -AsPlainText -Force) `
 -Force:$true