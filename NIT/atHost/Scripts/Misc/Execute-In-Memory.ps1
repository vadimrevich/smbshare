$comd = Get-Content "$env:UserProfile\echo-hello-macro.ps1" | Out-String
#$comd
Invoke-Expression $comd