#Requires -Version 5.1
#Requires -RunAsAdministrator

###########################################################
# NIT.Get-MistakeStoppedServices.ps1
# This Script will get the names of services to be stopped
# which must be run with operation system
#
###########################################################

# Powershell 5.1
Get-CimInstance -ClassName Win32_Service | Where-Object { $_.StartMode -eq 'Auto' -and $_.State -ne 'Running' } | Select-Object Name, DisplayName, State, StartMode

# Powershell 2.0
# Get-WmiObject Win32_Service -Filter "StartMode = 'Auto' AND State != 'Running'" | Select-Object Name, StartName, State

