Set-StrictMode -Version Latest
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'
trap {
    Write-Host
    Write-Host "ERROR: $_"
    ($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1' | Write-Host
    ($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$','ERROR EXCEPTION: $1' | Write-Host
    Write-Host
    Write-Host 'Sleeping for 60m to give you time to look around the virtual machine before self-destruction...'
    Start-Sleep -Seconds (60*60)
    Exit 1
}

Write-Host 'Disabling the Microsoft Consumer Experience...'
mkdir -Force 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent' | Set-ItemProperty `
    -Name DisableWindowsConsumerFeatures `
    -Value 1

# when running on pwsh and windows 10, explicitly import the appx module.
# see https://github.com/PowerShell/PowerShell/issues/13138
$currentVersionKey = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
$build = [int]$currentVersionKey.CurrentBuildNumber
if (($PSVersionTable.PSEdition -ne 'Desktop') -and ($build -lt 22000)) {
    Import-Module Appx -UseWindowsPowerShell
}

# remove all the provisioned appx packages.
# NB some packages fail to be removed and thats OK.
Get-AppXProvisionedPackage -Online | ForEach-Object {
    Write-Host "Removing the $($_.PackageName) provisioned appx package..."
    try {
        $_ | Remove-AppxProvisionedPackage -Online | Out-Null
    } catch {
        Write-Output "WARN Failed to remove appx: $_"
    }
}

# remove appx packages.
# NB some packages fail to be removed and thats OK.
# see https://learn.microsoft.com/en-us/windows/application-management/overview-windows-apps
@(
    'Microsoft.BingWeather'
    'Microsoft.GetHelp'
    'Microsoft.Getstarted'
    'Microsoft.Microsoft3DViewer'
    'Microsoft.MicrosoftOfficeHub'
    'Microsoft.MicrosoftSolitaireCollection'
    'Microsoft.MicrosoftStickyNotes'
    'Microsoft.MixedReality.Portal'
    'Microsoft.Office.OneNote'
    'Microsoft.ScreenSketch'
    'Microsoft.Services.Store.Engagement'
    'Microsoft.SkypeApp'
    'Microsoft.WindowsAlarms'
    'Microsoft.WindowsCamera'
    'Microsoft.WindowsMaps'
    'Microsoft.WindowsSoundRecorder'
    'Microsoft.Xbox.TCUI'
    'Microsoft.XboxApp'
    'Microsoft.XboxGameOverlay'
    'Microsoft.XboxGamingOverlay'
    'Microsoft.XboxSpeechToTextOverlay'
    #'Microsoft.BioEnrollment' # NB this fails to remove.
) | ForEach-Object {
    $appx = Get-AppxPackage -AllUsers $_
    if ($appx) {
        Write-Host "Removing the $($appx.Name) appx package..."
        try {
            $appx | Remove-AppxPackage -AllUsers
        } catch {
            Write-Output "WARN Failed to remove appx: $_"
        }
    }
}
