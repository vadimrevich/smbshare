<#
.SYNOPSIS
    This function create new AppLocker settings using 
    Set-AppLockerPolicy command and a policy XML File
.DESCRIPTION
    This script will create AppLocker settings for a Policy
.NOTES
    File name: Set-NIT-AppLocker-Policy-001.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2022-12-18
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2022-12-18) Script created
    1.0.1 - 
#>

### Define System Function

function Test-IsAdmin {
    try {
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal -ArgumentList $identity
        return $principal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )
    } catch {
        throw "Failed to determine if the current user has elevated privileges. The error was: '{0}'." -f $_
    }
}

### User Defined Variables. May be Changed

# AppLocker Policy XML Files

$aPolicyFile001="NIT-AppLocker-Policy-001.xml"
$aPolicyFile002="NIT-AppLocker-Policy-001.xml"
$aPolicyFile003="NIT-AppLocker-Policy-001.xml"

### System Defined Variables. May be Canged

$aProductDirectory="C:\.BIN\smbshare\NIT\NonInteractive\PWSH\NIT-AppLocker-Policy"
$aProductDirectory="d:\yuden\Download"

## Prepare Files

$aPolicyFile001=$aProductDirectory+"\"+$aPolicyFile001
$aPolicyFile002=$aProductDirectory+"\"+$aPolicyFile002
$aPolicyFile003=$aProductDirectory+"\"+$aPolicyFile003

$aTestF001=Test-Path $aPolicyFile001
$aTestF002=Test-Path $aPolicyFile002
$aTestF003=Test-Path $aPolicyFile003
$isAdmin=Test-IsAdmin
# $isAdmin=$false

### Run Algorythm
if( $aTestF001 ) {
    if( $aTestF002 ) {
        if( $aTestF003 ) {
            if( $isAdmin ) {
                Set-AppLockerPolicy -XmlPolicy $aPolicyFile001
                # Set-AppLockerPolicy -XmlPolicy $aPolicyFile002 -Merge
                # Set-AppLockerPolicy -XmlPolicy $aPolicyFile003 -Merge
                Write-Host The AppLockers Rules Add Successfully!
            }
            else {
                Write-Host The Script Runs without Elevated Privileges
            }
        }
        else {
            Write-Host File $aPolicyFile002 not Found
        }
    }
    else {
        Write-Host File $aPolicyFile002 not Found
    }
}
else {
    Write-Host File $aPolicyFile001 not Found
}
