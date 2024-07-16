# doc https://learn.microsoft.com/en-us/windows/iot/iot-enterprise/deployment/install-winget-windows-iot
# blog https://www.outsidethebox.ms/22409

$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'

$AppInstaller = 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
$VCLibs = 'Microsoft.VCLibs.x64.14.00.Desktop.appx'
$Xaml = 'Microsoft.UI.Xaml.2.8.x64.appx'
$components = @($VCLibs, $Xaml, $AppInstaller)
$license = '5e4a105df01840b0bbf00985e4f57c1e_License1.xml' #from v1.7.10582 assets

Write-Host "Downloading winget and dependencies..."
Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile .\$AppInstaller
Invoke-WebRequest -Uri https://aka.ms/$($VCLibs) -OutFile .\$VCLibs
Invoke-WebRequest -Uri https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/$($Xaml ) -OutFile .\$Xaml 
(Invoke-RestMethod -Uri https://github.com/microsoft/winget-cli/releases/download/v1.7.10582/$($license)).OuterXML | Out-File $license

Write-Host "Installing winget..."
# Deploy provisional package for all users
Add-AppxProvisionedPackage -Online -PackagePath .\$($AppInstaller) -LicensePath .\$($license)
Remove-Item -Path .\$($license) -Force

$components  | ForEach-Object {
    # Install downloaded packages...
    Add-AppxPackage -Path .\$($_) -ErrorAction 0
    # ... and delete them
    Remove-Item -Path .\$($_) -Force
}

# if anything went wrong, check out errors
if ($ERROR) {$ERROR | Out-File -FilePath $env:temp\winget-install.log -Append}

# Software installation 
Start-Sleep -Seconds 10 #before installing software

Write-Host "Installing apps with winget..."
[hashtable]$apps = @{
    "NanaZip" = "9N8G7TSCL18R"
    "Notepad++" = "Notepad++.Notepad++"
    "Total Commander" = "Ghisler.TotalCommander"
    "KeePass" = "DominikReichl.KeePass"
}

foreach ($key in $apps.keys) {
    winget install --id $($apps[$key]) -e --accept-package-agreements --accept-source-agreements
}
