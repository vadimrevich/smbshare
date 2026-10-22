#####
# Get-ExclusionPath.Defender.ps1
# This Comandlet will Get an Exclusions List for Local Computer
#####

# Set a Variable

$anEncoding = "Default" # Ansi at Powershell 7.4
$aFilaName = "Exclusions.Path.Defender.ps1.txt"
$LocalPath = Join-Path -Path $env:UserProfile -ChildPath $aFilaName
$aWidth = 1024

Get-MpPreference | Select-Object -ExpandProperty ExclusionPath | Out-File -FilePath $LocalPath -Encoding $anEncoding -Width $aWidth
