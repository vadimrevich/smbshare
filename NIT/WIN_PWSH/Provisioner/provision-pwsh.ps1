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

# enable TLS 1.2.
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol `
    -bor [Net.SecurityProtocolType]::Tls12

# disable update notifications.
# see https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_update_notifications?view=powershell-7.2
$env:POWERSHELL_UPDATECHECK = 'Off'
[Environment]::SetEnvironmentVariable(
    'POWERSHELL_UPDATECHECK',
    $env:POWERSHELL_UPDATECHECK,
    'Machine')

# install powershell lts.
# see https://github.com/PowerShell/PowerShell/releases
$archiveUrl = 'https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/PowerShell-7.4.0-win-x64.msi'
# $archiveHash = 'a6f86d833acb37a76b33ccba38271c5957cc133c4ee71171a235bde91d5691a3'
$archiveName = Split-Path -Leaf $archiveUrl
$archivePath = "$env:TEMP\$archiveName"

Write-Host "Downloading $archiveName..."
(New-Object Net.WebClient).DownloadFile($archiveUrl, $archivePath)
$archiveActualHash = (Get-FileHash $archivePath -Algorithm SHA256).Hash
#if ($archiveHash -ne $archiveActualHash) {
#    throw "$archiveName downloaded from $archiveUrl to $archivePath has $archiveActualHash hash witch does not match the expected $archiveHash"
#}

Write-Host "Installing $archiveName..."
msiexec /i $archivePath `
    /qn `
    /L*v "$archivePath.log" `
    ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 `
    ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 `
    ENABLE_PSREMOTING=1 `
    REGISTER_MANIFEST=1 `
    USE_MU=1 ENABLE_MU=1 `
    ADD_PATH=1 `
    | Out-String -Stream
if ($LASTEXITCODE) {
    throw "$archiveName installation failed with exit code $LASTEXITCODE. See $archivePath.log."
}
Remove-Item $archivePath
