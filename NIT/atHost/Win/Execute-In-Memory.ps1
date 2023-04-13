###########################################################
# Execute-In-Memory
# This Script Runs a Test Running of other Script
# from a Memory
###########################################################
$comd = Get-Content "$env:UserProfile\echo-hello-macro.ps1" | Out-String
#$comd
Invoke-Expression $comd