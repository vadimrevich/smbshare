<#
.SYNOPSIS
    This Script will Mount nit-iso.iso Disk Image
.DESCRIPTION
    This Script will Mount nit-iso.iso Disk Image
    on Windows 10.0 Core/Desktop Local Server
.NOTES
    File name: NIT.Mount.nit-iso.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-10-01
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-10-01) Script created
    1.0.1 - 
#>
###########################################################
# NIT.Mount.nit-iso
# This Script will Mount nit-iso.iso Disk Image
###########################################################

### Set Variables
#
$MyDownloads = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$MyDocuments = [Environment]::GetFolderPath("MyDocuments")
$MyDesktop = [Environment]::GetFolderPath("Desktop")

$aFile = "nit-iso.iso"
$aUser="Администратор"


### Defivative Variabled

$ALocalPath = Join-Path -Path $MyDownloads -ChildPath $aFile

### Set Functions
#
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# Set Functions

function NITMount-nit-iso {

    Mount-DiskImage -ImagePath $ALocalPath -StorageType ISO
    Get-PSDrive -PSProvider FileSystem
}

function NITUnMount-nit-iso {

    Dismount-DiskImage -ImagePath $ALocalPath -StorageType ISO
    Get-PSDrive -PSProvider FileSystem
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
NITMount-nit-iso


#Main function
