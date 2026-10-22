#Requires -Version 5.1
#Requires -RunASAdministrator

#####
# NIT.Prepare000-WinServer.ps1
# This Script will prepare postinstallation
# on Microsoft Windows server operation systems
# It will:
# # Allow WMIC.exe and VBScript.exe
# # Add Some Windows Exclusions
# # Add Main Windows Features (SMB1, Powershell V2, .NetFx3, Telnet Client, TFTP Client)
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

function Install_DISM000 {

# 'running with full privileges'

	# Install WMIC.exe and VBScript
	& DISM.exe /Online /Add-Capability /CapabilityName:WMIC~~~~ /NoRestart
	& DISM.exe /Online /Add-Capability /CapabilityName:VBSCRIPT~~~~ /NoRestart

}

function Install_DefenderExclusions00 {

	# Set Exclusions
	Add-MpPreference -ExclusionPath $(Get-MyDocumentsShellFolder)
    Add-MpPreference -ExclusionPath $DownloadShellFolder
    Add-MpPreference -ExclusionPath $MyDesktop
    Add-MpPreference -ExclusionPath $env:SystemRoot
}

function Insall-Install_DISM000 {

	& DISM.exe /Online /Enable-Feature /FeatureName:NetFx3 /All /NoRestart
	& DISM.exe /Online /Enable-Feature /FeatureName:NetFx4 /All /NoRestart
	& DISM.exe /Online /Enable-Feature /FeatureName:NetFx4-AdvSrvs /All /NoRestart
	& DISM.exe /Online /Enable-Feature /FeatureName:SmbDirect /All /NoRestart
	& DISM.exe /Online /Enable-Feature /FeatureName:SMB1Protocol /All /NoRestart
	& DISM.exe /Online /Enable-Feature /FeatureName:SMB1Protocol-Client /All /NoRestart
	& DISM.exe /Online /Enable-Feature /FeatureName:SMB1Protocol-Server /All /NoRestart
	& DISM.exe /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShellV2 /All /NoRestart
	& DISM.exe /Online /Enable-Feature /FeatureName:MicrosoftWindowsPowerShellV2Root /All /NoRestart
	& DISM.exe /Online /Enable-Feature /FeatureName:TelnetClient /All /NoRestart
	& DISM.exe /Online /Enable-Feature /FeatureName:TFTP /All /NoRestart
}

function Install_NetFramework48 {

    # Set Variables
    $mainURL = "http://win.netip4.ru/Apps/smbshare/MSFT/dotNet/ndp48-x86-x64-allos-enu.exe"
    $anExeFile = Join-Path -Path $DownloadShellFolder -ChildPath "ndp48-x86-x64-allos-enu.exe"

    # Run Payloads
    $wc.DownloadFile($mainURL, $anExeFile)
    & $anExeFile  /quiet /norestart
}

function Install_AIO_VCRedist {

    # Set Variables
    $mainURL0 = "http://win.netip4.ru/Apps/smbshare/MSFT/VCRedist/x64/VCRHyb64.exe"
    $mainURL1 = "http://win.netip4.ru/Apps/smbshare/MSFT/VCRedist/x64/RuntimePack_Lite_x86_x64.exe"
    $anExeFile0 = Join-Path -Path $DownloadShellFolder -ChildPath "VCRHyb64.exe"
    $anExeFile1 = Join-Path -Path $DownloadShellFolder -ChildPath "RuntimePack_Lite_x86_x64.exe"

    # Run Payloads
    $wc.DownloadFile($mainURL0, $anExeFile0)
    $wc.DownloadFile($mainURL1, $anExeFile1)
    & $anExeFile0 /S
    & $anExeFile1  -y -gm2 -fm0
}

function Import-WinUpdate {

    # Set Variables
    $mainURL = "http://win.netip4.ru/Apps/smbshare/NIT/atHost/PSModules/New-LoadAndInstall.Modules.Example.ps1"
    $aps1File = Join-Path -Path $DownloadShellFolder -ChildPath "New-LoadAndInstall.Modules.Example.ps1"

    # Run Payloads
    $wc.DownloadFile($mainURL, $aps1File) 
    & $aps1File

}

Install_DISM000
Install_DefenderExclusions00
Insall-Install_DISM000
Install_AIO_VCRedist
Install_NetFramework48
Import-WinUpdate
