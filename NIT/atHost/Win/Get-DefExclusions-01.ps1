###########################################################
# Get-DefExclusions-01.ps1
# This Script Gets a Microsoft Windows Defender Exclusions
# on Local Computers
#
###########################################################

# Out Folder Exclusions
Write-Host " "
Write-Host "Out Exclusion Paths"
Get-MpPreference | Select-Object -Property ExclusionPath -ExpandProperty ExclusionPath

# Out Process Exclusions
Write-Host " "
Write-Host "Out Exclusion Processes"
Get-MpPreference | Select-Object -Property ExclusionProcess -ExpandProperty ExclusionProcess

# Out Extension Exclusions
Write-Host " "
Write-Host "Out Exclusion Extensionss"
Get-MpPreference | Select-Object -Property ExclusionExtensions -ExpandProperty ExclusionExtension

# Out Extension Exclusions
Write-Host " "
Write-Host "Out Exclusion IP Address"
Get-MpPreference | Select-Object -Property ExclusionIpAddress -ExpandProperty ExclusionIpAddress

