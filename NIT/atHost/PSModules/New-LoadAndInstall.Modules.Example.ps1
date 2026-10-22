#Requires -Version 5.1
#Requires -RunASAdministrator

#####
# New-LoadAndInstall.Modules.Example.ps1
# This Script will prepare postinstallation
# on Microsoft Windows server operation systems
# It will:
# # Allow PSWindowsUpdate Module
# # Allow NITcdChange Module
#
#####


#### Set Variables ####

### Set Functions
#

Function Check-DownloadShellFolder() {
    try {
        $DownloadShellFolder=(New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
    }
    catch {
        Write-Host "Download Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "Download Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "Download Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

function Get-MyDocumentsShellFolder() {
    $MyDocuments = 5 #System.Environment.SpecialFolder.MyDocuments
    [System.Environment]::GetFolderPath($MyDocuments)
}

function Get-UserProfileShellFolder() {
    if( !$env:USERPROFILE ) {
        return $null
    }
    else {
        $env:USERPROFILE
    }
}


Function Check-MyDocumentsShellFolder() {
    try {
        $DownloadShellFolder=Get-MyDocumentsShellFolder
    }
    catch {
        Write-Host "My Documents Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "My Documents Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "My Documents Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

Function Check-UserProfileShellFolder() {
    try {
        $DownloadShellFolder=Get-UserProfileShellFolder
    }
    catch {
        Write-Host "User Profile Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "User Profile Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "User Profile  Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

### Set Functions
#

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

$MyDesktop = [Environment]::GetFolderPath("Desktop")

$DownloadShellFolder=(New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$aServerURL="http://win.netip4.ru/Apps/smbshare/NIT/atHost/Win/"
# $aLocationPath=$env:TEMP
$aLocationPath=$DownloadShellFolder

# Check Integrity
if( !( Test-Path -Path $aLocationPath -PathType Container) ){
    Write-Host "Error! $aLocationPath is not Found"
    Exit 1
}

# Set wc Object
$wc = New-Object System.Net.WebClient

# Set Functions

function Download_PSWindowsUpdate {

    # Set Variables
    $aModule = "PSWindowsUpdate"
    $mainURL = "http://win.netip4.ru/Apps/smbshare/NIT/atHost/PSModules/" + $aModule + ".zip"

    # Create Module Directory
    $aDir = Join-Path -Path $(Get-MyDocumentsShellFolder) -ChildPath "WindowsPowerShell"
    if( -not (Test-Path -Path $aDir )){
        mkdir $aDir
    }
    $aDir = Join-Path -Path $aDir -ChildPath "Modules"
    if( -not (Test-Path -Path $aDir )){
        mkdir $aDir
    }

    $aNumber="2.2.1.5"
    $ZipFile = $aModule + ".zip"
    $psdFile = $aModule + "\" +$aNumber +"\" + $aModule + ".psd1"
    $psmFile = $aModule + "\" +$aNumber +"\" + $aModule + ".psm1"
    $aZipFile = Join-Path -Path $aDir -ChildPath $ZipFile
    $apsdFile = Join-Path -Path $aDir -ChildPath $psdFile
    $apsmFile = Join-Path -Path $aDir -ChildPath $psmFile

    Write-Host $mainURL
    Write-Host $aZipFile
    
    # Run Payloads
    $wc.DownloadFile($mainURL, $aZipFile)
    Expand-Archive -Path $aZipFile -DestinationPath $aDir -Force
        Import-Module -Name $apsmFile -Verbose -Force
        Import-Module -Name $apsdFile -Verbose -Force
}


function Download_VcRedist {

    # Set Variables
    $aModule = "VcRedist"
    $mainURL = "http://win.netip4.ru/Apps/smbshare/NIT/atHost/PSModules/" + $aModule + ".zip"

    # Create Module Directory
    $aDir = Join-Path -Path $(Get-MyDocumentsShellFolder) -ChildPath "WindowsPowerShell"
    if( -not (Test-Path -Path $aDir )){
        mkdir $aDir
    }
    $aDir = Join-Path -Path $aDir -ChildPath "Modules"
    if( -not (Test-Path -Path $aDir )){
        mkdir $aDir
    }

    $aNumber="4.1.526"
    $ZipFile = $aModule + ".zip"
    $psdFile = $aModule + "\" +$aNumber +"\" + $aModule + ".psd1"
    $psmFile = $aModule + "\" +$aNumber +"\" + $aModule + ".psm1"
    $aZipFile = Join-Path -Path $aDir -ChildPath $ZipFile
    $apsdFile = Join-Path -Path $aDir -ChildPath $psdFile
    $apsmFile = Join-Path -Path $aDir -ChildPath $psmFile

    Write-Host $mainURL
    Write-Host $aZipFile
    
    # Run Payloads
    $wc.DownloadFile($mainURL, $aZipFile)
    Expand-Archive -Path $aZipFile -DestinationPath $aDir -Force
        Import-Module -Name $apsmFile -Verbose -Force
        Import-Module -Name $apsdFile -Verbose -Force
}


function Download_NITcdChange {

    # Set Variables
    $aModule = "NITcdChange"
    $mainURL = "http://win.netip4.ru/Apps/smbshare/NIT/atHost/PSModules/" + $aModule + ".zip"

    # Create Module Directory
    $aDir = Join-Path -Path $(Get-MyDocumentsShellFolder) -ChildPath "WindowsPowerShell"
    if( -not (Test-Path -Path $aDir )){
        mkdir $aDir
    }
    $aDir = Join-Path -Path $aDir -ChildPath "Modules"
    if( -not (Test-Path -Path $aDir )){
        mkdir $aDir
    }

    $ZipFile = $aModule + ".zip"
    $psdFile = $aModule +"\" + $aModule + ".psd1"
    $psmFile = $aModule +"\" + $aModule + ".psm1"
    $aZipFile = Join-Path -Path $aDir -ChildPath $ZipFile
    $apsdFile = Join-Path -Path $aDir -ChildPath $psdFile
    $apsmFile = Join-Path -Path $aDir -ChildPath $psmFile

    
    Write-Host $mainURL
    Write-Host $aZipFile
    
    # Run Payloads
    $wc.DownloadFile($mainURL, $aZipFile)
    Expand-Archive -Path $aZipFile -DestinationPath $aDir -Force
        Import-Module -Name $apsmFile -Verbose -Force
        Import-Module -Name $apsdFile -Verbose -Force
}

Download_NITcdChange
Download_PSWindowsUpdate
Download_VcRedist
