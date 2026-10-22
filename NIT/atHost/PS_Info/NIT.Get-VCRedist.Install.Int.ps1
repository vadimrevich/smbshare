#Requires -Version 5.1

#####
# NIT.Get-VCRedist.ps1
# This Script will get Visual Studio C++ Redistributible Versions
# on Microsoft Windows server operation systems
#
#####

#### Set Variables ####

#### Run Payloads ####

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
$VisualRedistScript = Invoke-WebRequest https://raw.githubusercontent.com/UltimateNova1203/visual-redist/master/visual-redist.ps1 -UseBasicParsing
Invoke-Expression $($VisualRedistScript.Content)
