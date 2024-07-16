# Install-Winget Version v1.0.11692
# Andreas Nick 2021

# From github
$VC14x64_Link = 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'
$VC14x86_Link = 'https://aka.ms/Microsoft.VCLibs.x86.14.00.Desktop.appx'
$VC14x64_Name = 'Microsoft.VCLibs.x64.14.00.Desktop.appx'
$VC14x86_Name = 'Microsoft.VCLibs.x86.14.00.Desktop.appx'

$RepoName = 'AppPAckages'
$RepoLokation = $env:Temp
$Packagename = 'Winget'

$RepoPath = Join-Path $RepoLokation -ChildPath $RepoName 
$RepoPath = Join-Path $RepoPath -ChildPath $Packagename

if(-not (Test-Path $RepoPath ))
{
    New-Item $RepoPath -ItemType Directory -Force
}

if( Test-Path (Join-Path $RepoPath -ChildPath $VC14x64_Name )) {
    ri -Path (Join-Path $RepoPath -ChildPath $VC14x64_Name ) -Force
}

if( Test-Path (Join-Path $RepoPath -ChildPath $VC14x86_Name )) {
    ri -Path (Join-Path $RepoPath -ChildPath $VC14x86_Name ) -Force
}

Invoke-WebRequest -Uri $VC14x64_Link -OutFile (Join-Path $RepoPath -ChildPath $VC14x64_Name )
Invoke-WebRequest -Uri $VC14x86_Link -OutFile (Join-Path $RepoPath -ChildPath $VC14x86_Name )


#Install the Package
Add-AppPackage (Join-Path $RepoPath -ChildPath $VC14x64_Name )
# Add-AppPackage (Join-Path $RepoPath -ChildPath $VC14x86_Name )


