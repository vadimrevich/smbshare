###########################################################
# echo-hello-macro.ps1
# This Macro Runs an echo-helloo.bat Test Script
# from a Hard Disk via Powershell
###########################################################

$echoHello = "$env:UserProfile\echo-hello.bat"
$cmd = "$env:ComSpec /c "
$comd = $cmd + $echoHello
Invoke-Expression $comd