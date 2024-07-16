# Install-Winget Version v1.0.11692
# Andreas Nick 2021

# From github
$WinGet_Link = 'https://github.com/microsoft/winget-cli/releases/download/v1.7.10661/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
$WinGet_LicLink = 'https://github.com/microsoft/winget-cli/releases/download/v1.7.10661/9ea36fa38dd3449c94cc839961888850_License1.xml'
$WinGet_Name = 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
$WinGet_LicName = '9ea36fa38dd3449c94cc839961888850_License1.xml'

$RepoName = 'AppPAckages'
$RepoLokation = $env:Temp
$Packagename = 'Winget'

$RepoPath = Join-Path $RepoLokation -ChildPath $RepoName 
$RepoPath = Join-Path $RepoPath -ChildPath $Packagename

if(-not (Test-Path $RepoPath ))
{
    New-Item $RepoPath -ItemType Directory -Force
}

if( Test-Path (Join-Path $RepoPath -ChildPath $WinGet_Name ) ) {
    ri (Join-Path $RepoPath -ChildPath $WinGet_Name )
}

if( Test-Path (Join-Path $RepoPath -ChildPath $WinGet_LicName )) {
    ri (Join-Path $RepoPath -ChildPath $WinGet_LicName )
}

Invoke-WebRequest -Uri $WinGet_Link -OutFile (Join-Path $RepoPath -ChildPath $WinGet_Name )
Invoke-WebRequest -Uri $WinGet_LicLink -OutFile (Join-Path $RepoPath -ChildPath $WinGet_LicName )

#Install the Package
Add-AppPackage (Join-Path $RepoPath -ChildPath $WinGet_Name)

Add-AppxProvisionedPackage -Online -PackagePath (Join-Path $RepoPath -ChildPath $WinGet_Name) -LicensePath (Join-Path $RepoPath -ChildPath $WinGet_LicName ) -Verbose


