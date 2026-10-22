### Set a Search String

$aSearchString = "*wmic*"

### Run Payloads

Write-Host "Get Windows Capability for Windows 11`n"
Get-WindowsCapability -Online | Where-Object -FilterScript {$_.name -Like $aSearchString}

Write-Host "Get Windows Feature for Windows 11`n"
Get-WindowsOptionalFeature -Online | Where-Object -FilterScript {$_.featurename -Like $aSearchString}

Write-Host "Done!"
