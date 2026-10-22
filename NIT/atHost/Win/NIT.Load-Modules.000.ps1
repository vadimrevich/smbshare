#Requires -Version 5.1
#Requires -RunASAdministrator

###########################################################
# NIT.Load-Modules.000.ps1
# This Script will Install NITcdChange Module
# and Register It
# After you may Use Get-WindowsUpdate, 
# Download-WindowsUpdate and Install-WindowsUpdate
###########################################################

# Set Variables

$DocF=(New-Object -ComObject Shell.Application).NameSpace('shell:Personal').Self.Path
$aPath=Join-Path -Path $DocF -ChildPath "WindowsPowerShell"
if( -not (Test-Path -Path $aPath -PathType Container)) {
    & mkdir $aPath
}
$aPath=Join-Path -Path $aPath -ChildPath "Modules"
if( -not (Test-Path -Path $aPath -PathType Container)) {
    & mkdir $aPath
}

# Load Module NITcdChange
$psmPath = Join-Path $aPath -ChildPath "NITcdChange\NITcdChange.psm1"

if( Test-Path -Path $psmPath -PathType Leaf) {
    Import-Module -Name $psmPath -Force -Verbose
}

# Load Module hv-w10pro3
$psmPath = Join-Path $aPath -ChildPath "hv-w10pro3\hv-w10pro3.psm1"

if( Test-Path -Path $psmPath -PathType Leaf) {
    Import-Module -Name $psmPath -Force -Verbose
}

