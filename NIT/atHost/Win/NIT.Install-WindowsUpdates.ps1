#Requires -Version 5.1
#Requires -RunASAdministrator

###########################################################
# Install-PSWindowsUpdate
# This Script will Install PSWindowsUpdate Module
# and Register It
# After you may Use Get-WindowsUpdate, 
# Download-WindowsUpdate and Install-WindowsUpdate
###########################################################

# Source - https://translated.turbopages.orghttps://translated.turbopages.org/proxy_u/en-ru.ru.9216ddc7-695b2377-a8217964-74722d776562/https/stackoverflow.com/a
# Posted by cet51, modified by community. See post 'Timeline' for change history
# Retrieved 2026-01-05, License - CC BY-SA 3.0

$PSVersionTable.PSVersion

# Source - https://translated.turbopages.orghttps://translated.turbopages.org/proxy_u/en-ru.ru.9216ddc7-695b2377-a8217964-74722d776562/https/stackoverflow.com/a
# Posted by cet51, modified by community. See post 'Timeline' for change history
# Retrieved 2026-01-05, License - CC BY-SA 3.0

# Install-Module PSWindowsUpdate
$DocF=(New-Object -ComObject Shell.Application).NameSpace('shell:Personal').Self.Path
$aPath=Join-Path -Path $DocF -ChildPath "WindowsPowerShell"
if( -not (Test-Path -Path $aPath -PathType Container)) {
    Exit 1
}
$aPath=Join-Path -Path $aPath -ChildPath "Modules"
if( -not (Test-Path -Path $aPath -PathType Container)) {
    Exit 1
}

$psmPath = Join-Path $aPath -ChildPath "PSWindowsUpdate\2.2.1.5\PSWindowsUpdate.psm1"
if( -not (Test-Path -Path $psmPath -PathType Leaf )) {
    Write-Host "No module PSWindowsUpdate to be Installed"
    Exit 1
}

Import-Module -Name $psmPath -Force -Verbose

# Source - https://translated.turbopages.orghttps://translated.turbopages.org/proxy_u/en-ru.ru.9216ddc7-695b2377-a8217964-74722d776562/https/stackoverflow.com/a
# Posted by cet51, modified by community. See post 'Timeline' for change history
# Retrieved 2026-01-05, License - CC BY-SA 3.0

Get-WindowsUpdate

Download-WindowsUpdate -AcceptAll

Install-WindowsUpdate -AcceptAll -AutoReboot

# Get-WUInstall –MicrosoftUpdate –AcceptAll –AutoReboot
