#####
# NIT-AllUserInboxAppsKey.ps1
#####

### Set a variables

# $MyScript=[Environment]::GetCommandLineArgs()[0]
$MyScript=$MyInvocation.InvocationName

# Run Payload....

$AllUserInboxAppsKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications"
$AllUserApps = Get-ChildItem -Path $AllUserInboxAppsKey
ForEach($Key in $AllUserApps) {
    Add-AppxPackage -DisableDevelopmentMode -Register (Get-ItemProperty -Path $Key.PsPath).Path
}

$AllUserAppsKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Applications"
$AllUserApps = Get-ChildItem -Path $AllUserAppsKey
ForEach($Key in $AllUserApps) {
    Add-AppxPackage -DisableDevelopmentMode -Register (Get-ItemProperty -Path $Key.PsPath).Path
}

# End
Write-Host "The End of the Script $MyScript"
Exit 0
