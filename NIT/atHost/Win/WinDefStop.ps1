#Requires -Version 5.1
#Requires -RunAsAdministrator

###########################################################
# WinDefStop.ps1
# Stop Windows Defender Active Monitoring
# You must Disable a tamper protection previously
###########################################################

Set-MpPreference -DisableRealtimeMonitoring $true

