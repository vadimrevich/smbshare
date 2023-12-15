Set-StrictMode -Version Latest
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'
trap {
    Write-Host
    Write-Host "ERROR: $_"
    ($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1' | Write-Host
    ($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$','ERROR EXCEPTION: $1' | Write-Host
    Write-Host
    # Write-Host 'Sleeping for 60m to give you time to look around the virtual machine before self-destruction...'
    # Start-Sleep -Seconds (60*60)
    Exit 1
}

# Create Variables
#
$aLogin="Administrator"
$aPassword="0A9s8d7F"
$anAdminGroup="Administrators"
$anUserGroup="Users"

$aUserPassword = ConvertTo-SecureString $aPassword -AsPlainText -Force

# Run a Payloads
#

# Set New Password...
Set-LocalUser -Name $aLogin -Password $aUserPassword 
Set-LocalUser -Name $aLogin –PasswordNeverExpires $True
Disable-LocalUser -Name $aLogin

$AdsScript              = 0x00001
$AdsAccountDisable      = 0x00002
$AdsNormalAccount       = 0x00200
$AdsDontExpirePassword  = 0x10000
$account = [ADSI]'WinNT://./Administrator'
$account.Userflags = $AdsNormalAccount -bor $AdsDontExpirePassword -bor $AdsAccountDisable
$account.SetInfo()
