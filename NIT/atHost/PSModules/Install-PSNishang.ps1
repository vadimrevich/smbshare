<#
    .SYNOPSIS
        This Script will Download a GitHub Repository
    .DESCRIPTION
        This Script will Download a GitHub Repository
        on Windows 8.1/10/11 or Windows Server 2012R2+ Computers
    .NOTES
    	File name: Install-PSNishang.ps1
    	VERSION: 1.0.0a
    	AUTHOR: New Internet Technologies Inc.
    	Created:  2023-12-20
    	Licensed under the BSD license.
    	Please credit me if you find this script useful and do some cool things with it.
    .VERSION HISTORY:
    	1.0.0 - (2023-12-20) Script created
    	1.0.1 - 
#>
# Set a Version of PowerShell
#Requires -Version 5.0
Write-Host "I'm a Version 5.0+ and above"


# The Function Returns a Path to Folder "My Documents"
function MyDocumentsPath
{
    $MyDocuments = 5 #System.Environment.SpecialFolder.MyDocuments
    [System.Environment]::GetFolderPath($MyDocuments)
}

### Set Downloads and Documents Folder
##
$aDownloads=(New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$aDocuments = MyDocumentsPath

### Set Downloads Variables
##
# A Repository URL with a ZIP File
$aRepositoryUrl="https://github.com/samratashok/nishang/archive/refs/tags/v0.7.6.zip"
# An an Output ZIP File name
$anOutZipFileName="nishang-0.7.6.zip"
# An Output Folder Name
$aDestFolderName="Nishang"
$aDestParentFolderName=Join-Path -Path $aDocuments -ChildPath "WindowsPowerShell\Modules"
# A Downloading Folder Name
$anOutZipFolderName="nishang-0.7.6"

### Derivative Variables
###
$OutputZipFile= Join-Path -Path $aDownloads -ChildPath $anOutZipFileName
$aDestFolder = Join-Path -Path $aDestParentFolderName -ChildPath $aDestFolderName
$OutDestFolder = Join-Path -Path $aDestParentFolderName -ChildPath $anOutZipFolderName

### Run Payloads
Write-Host "Run Payloads..."
#
#Invoke-WebRequest 'https://github.com/ironmansoftware/plinqo/archive/refs/heads/main.zip' -OutFile .\plinqo.zip
#Expand-Archive .\plinqo.zip .\
#Rename-Item .\plinqo-main .\plinqo
#Remove-Item .\plinqo.zip

try 
{
    $Response = Invoke-WebRequest -Uri $aRepositoryUrl -OutFile $OutputZipFile -ErrorAction Stop
    $StatusCode = $Response.StatusCode
}
Catch
{
    Write-Host "Inner Exeption = $_`n"
    Exit 1
}
if( Test-Path $aDestFolder ) {
    ri -Path $aDestFolder -Force -Recurse
}
if( Test-Path $OutDestFolder ) {
    ri -Path $OutDestFolder -Force -Recurse
}
Expand-Archive -Path $OutputZipFile -DestinationPath $aDestParentFolderName
Rename-Item -Path $OutDestFolder $aDestFolder
Remove-Item -Path $OutputZipFile

# Install Nishang Module
#
$curdir = Get-Location
Set-Location $aDestFolder
Import-Module .\nishang.psm1
Set-Location $curdir

Write-Host "The End of the Script $0"
Exit 0
