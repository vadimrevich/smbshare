#Requires -Version 2
<#
.SYNOPSIS
    This Script will Show Standard User Folders
.DESCRIPTION
    This Script will Show Standard User Folders
.NOTES
    File name: NIT.Get-FolderNames.000.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2025-11-06
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2025-11-06) Script created
    1.0.1 - 
#>

### Set Variables
#
$MyDownloads = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$MyDocuments = [Environment]::GetFolderPath("MyDocuments")
$MyDesktop = [Environment]::GetFolderPath("Desktop")

### Run Payloads  ###
Write-Host "`r`n"
Write-Host "My Downloads Folder: $MyDownloads"
Write-Host "My Documents Folder: $MyDocuments"
Write-Host "My Desktop Folder: $MyDesktop"

### Write in Russian
Write-Host "`r`n"
Write-Host "Папка «Загрузки» текущего пользователя: $MyDownloads"
Write-Host "Папка «Мои документы» текущего пользователя: $MyDocuments"
Write-Host "Папка «Рабочий стол» текущего пользователя: $MyDesktop"

#### The Ebd
Write-Host "`r`n"
Exit 0

