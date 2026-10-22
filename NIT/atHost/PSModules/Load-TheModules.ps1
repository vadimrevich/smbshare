#Requires -Version 5.1
#Requires -RunAsAdministrator

###########################################################
# Load-TheModules
# The Script is Re-Load a NIT Modules from Locale Computer
# The Script must be Run with Elevated Privileges
# Please Turn off Windows Defender for Running Script
###########################################################

# Set Variables

#### Set a Windows Modules SubPath
$SubPath="WindowsPowerShell\Modules"

#### Set a My Documents Path (must be changed)
#$DocPath0="C:\Users\user\Documents"
$DocPath0="d:\yuden\Documents"

$USerModulesPath=Join-Path -Path $DocPath0 -ChildPath $SubPath

### Set User's Module Subpaths
$SubPath01="hv-w10pro3\hv-w10pro3.psm1"
$SubPath02="NITcdChange\NITcdChange.psm1"
$SubPath03="AntivirusBypass\AntivirusBypass.psm1"
$SubPath04="CodeExecution\CodeExecution.psm1"
$SubPath05="Exfiltration\Exfiltration.psm1"
$SubPath06="Invoke-Obfuscation\Invoke-Obfuscation.psd1"
$SubPath07="Invoke-TheHash\Invoke-TheHash.psd1"
$SubPath08="MyTestConnections\MyTestConnections.psm1"
$SubPath09="Nishang\Nishang.psm1"
$SubPath10="NTLMX\1.0.0\NTLMX.psm1"
$SubPath11="Persistence\Persistence.psm1"
$SubPath12="Pester\3.4.0\Pester.psm1"
$SubPath13="PoshNmap\0.6.1\PoshNmap.psm1"
$SubPath14="PowerSploit\PowerSploit.psm1"
$SubPath15="Privesc\Privesc.psm1"
$SubPath16="ps2exe\ps2exe.psm1"
$SubPath17="Recon\Recon.psm1"
$SubPath18="ScriptModification\ScriptModification.psm1"
$SubPath19="WSManTrust\0.1.45.0\WSManTrust.psm1"

### Run Payloads

### Disable Windows Defender
Set-MpPreference -DisableRealtimeMonitoring $true

### LOad Modules

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath01
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath02
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath03
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath04
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath05
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath06
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath07
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath08
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath09
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath10
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath11
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath12
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath13
# Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath14
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath15
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath16
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath17
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath18
Import-Module -Name $aPath -Force -Verbose

$aPath=Join-Path -Path $USerModulesPath -ChildPath $SubPath19
Import-Module -Name $aPath -Force -Verbose

### Enamle Windows Defender
Set-MpPreference -DisableRealtimeMonitoring $false
