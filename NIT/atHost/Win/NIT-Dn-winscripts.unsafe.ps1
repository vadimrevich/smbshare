<#
.SYNOPSIS
    This Script will Download and Mount winscripts
.DESCRIPTION
    This Script will Download and Mount winscripts
    on Windows 10 Local Computer
.NOTES
    File name: NIT-Dn-winscripts.unsafe.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-09-07
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-09-07) Script created
    1.0.1 - 
#>
#param([switch]$Elevated)

#### Set Variables

$MyDownloads = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$MyDocuments = [Environment]::GetFolderPath("MyDocuments")
$MyDesktop = [Environment]::GetFolderPath("Desktop")


$aUser="Администратор"
$clnt = new-object System.Net.WebClient


### Defivative Variabled

### Add Global Variables

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# Set Functions

function NIT-Dn-winscripts {

    $aFile = "NIT-UnblockFiles"
    $anURI = "http://documents.netip4.ru/NIT/winscripts/" + $aFile
    $ALocalPath = Join-Path -Path $MyDownloads -ChildPath $aFile
    $clnt.DownloadFile($anURI, $ALocalPath)


    $aFile = "NIT-New-AnyDeskInstall.ps1"
    $anURI = "http://documents.netip4.ru/NIT/winscripts/" + $aFile
    $ALocalPath = Join-Path -Path $MyDownloads -ChildPath $aFile
    $clnt.DownloadFile($anURI, $ALocalPath)


    $aFile = "NIT-Stop-Updates.ps1"
    $anURI = "http://documents.netip4.ru/NIT/winscripts/" + $aFile
    $ALocalPath = Join-Path -Path $MyDownloads -ChildPath $aFile
    $clnt.DownloadFile($anURI, $ALocalPath)

    $aFile = "NIT-DnMnt-nit-iso.ps1.ps1"
    $anURI = "http://documents.netip4.ru/NIT/winscripts/" + $aFile
    $ALocalPath = Join-Path -Path $MyDownloads -ChildPath $aFile
    $clnt.DownloadFile($anURI, $ALocalPath)

}

### Run Payloads

#if ((Test-Admin) -eq $false)  {
#    if ($elevated) {
#        # tried to elevate, did not work, aborting
#    } else {
##        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
#        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    #}
    #exit
#}

# 'running with full privileges'
NIT-Dn-winscripts
