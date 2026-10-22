#Requires -RunAsAdministrator

###########################################################
# NIT.Set-USALayout.ps1
###########################################################

# Set Variables

$EngLayout="0409:00000409"
$RusLayout="0419:00000419"

# Run Payload

Set-WinDefaultInputMethodOverride -InputTip "$EngLayout"
Get-WinDefaultInputMethodOverride

