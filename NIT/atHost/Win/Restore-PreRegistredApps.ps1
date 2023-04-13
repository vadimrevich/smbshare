###########################################################
# Restore-PreRegistredApps.ps1
# This Script Restores Default PreRegistred Apps
# at Windows Host with Metro Interface (Windows 8 and Later)
###########################################################
$manifest = (Get-AppxPackage Microsoft.NET.Native.Framework.1.7 | Where -Property Architecture -eq X86).InstallLocation + '\AppxManifest.xml' ; 
Add-AppxPackage -DisableDevelopmentMode -Register $manifest
$manifest = (Get-AppxPackage Microsoft.NET.Native.Framework.1.7 | Where -Property Architecture -eq X64).InstallLocation + '\AppxManifest.xml' ; 
Add-AppxPackage -DisableDevelopmentMode -Register $manifest
$manifest = (Get-AppxPackage Microsoft.NET.Native.Framework.2.2 | Where -Property Architecture -eq X86).InstallLocation + '\AppxManifest.xml' ; 
Add-AppxPackage -DisableDevelopmentMode -Register $manifest
$manifest = (Get-AppxPackage Microsoft.NET.Native.Framework.2.2 | Where -Property Architecture -eq X64).InstallLocation + '\AppxManifest.xml' ; 
Add-AppxPackage -DisableDevelopmentMode -Register $manifest
$manifest = (Get-AppxPackage Microsoft.NET.Native.Runtime.1.7 | Where -Property Architecture -eq X86).InstallLocation + '\AppxManifest.xml' ; 
Add-AppxPackage -DisableDevelopmentMode -Register $manifest
$manifest = (Get-AppxPackage Microsoft.NET.Native.Runtime.1.7 | Where -Property Architecture -eq X64).InstallLocation + '\AppxManifest.xml' ; 
Add-AppxPackage -DisableDevelopmentMode -Register $manifest
$manifest = (Get-AppxPackage Microsoft.NET.Native.Runtime.2.2 | Where -Property Architecture -eq X86).InstallLocation + '\AppxManifest.xml' ; 
Add-AppxPackage -DisableDevelopmentMode -Register $manifest
$manifest = (Get-AppxPackage Microsoft.NET.Native.Runtime.2.2 | Where -Property Architecture -eq X64).InstallLocation + '\AppxManifest.xml' ; 
Add-AppxPackage -DisableDevelopmentMode -Register $manifest
$manifest = (Get-AppxPackage Microsoft.VCLibs | Where -Property Architecture -eq X86).InstallLocation + '\AppxManifest.xml' ; 
Add-AppxPackage -DisableDevelopmentMode -Register $manifest
$manifest = (Get-AppxPackage Microsoft.VCLibs | Where -Property Architecture -eq X64).InstallLocation + '\AppxManifest.xml' ; 
Add-AppxPackage -DisableDevelopmentMode -Register $manifest
$manifest = (Get-AppxPackage Microsoft.UI.Xaml.2.4 | Where -Property Architecture -eq X86).InstallLocation + '\AppxManifest.xml' ; 
Add-AppxPackage -DisableDevelopmentMode -Register $manifest
$manifest = (Get-AppxPackage Microsoft.UI.Xaml.2.4 | Where -Property Architecture -eq X64).InstallLocation + '\AppxManifest.xml' ; 
Add-AppxPackage -DisableDevelopmentMode -Register $manifest
