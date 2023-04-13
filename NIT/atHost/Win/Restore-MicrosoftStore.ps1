###########################################################
# Restore-MicrosoftStore.ps1
# This Script Restores (not Installs!) Default Microsoft 
# Store Apps at Windows Host with Metro Interface
# (Windows 8 and Later)
###########################################################

$manifest = (Get-AppxPackage Microsoft.WindowsStore).InstallLocation + '\AppxManifest.xml' ; 
Add-AppxPackage -DisableDevelopmentMode -Register $manifest