#Requires -Version 5.1

#####
# NIT.Get-NetFrameworkVersion.ps1
# This Script will get .Net Framework Versions
# on Microsoft Windows server operation systems
#
#####

#### Set Variables ####

#### Run Payloads ####

Get-ChildItem ‘HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP’ -Recurse | Get-ItemProperty -Name version -EA 0 | Where { $_.PSChildName -Match ‘^(?!S)\p{L}’} | Select PSChildName, version

