###########################################################
#
# This Script Runs a Test PowerShell Macro as Expression
###########################################################

$comd = Get-Content "$env:UserProfile\echo-hello-macro.ps1" | Out-String
#$comd
Invoke-Expression $comd