##
# Smaller-Disk-Pwsh
# This Script is Reduced a Disk Space at Windows Guests Systems
#
##

## WinRM Settings ##

winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'

### Services Settings ###

&sc.exe config WSearch start= Demand
&sc.exe config Spooler start= Demand
&sc.exe config SharedAccess start= Demand
# &sc.exe config WlanSvc start= Demand
&sc.exe config FontCache start= Demand
&sc.exe config WpnService start= Demand
&sc.exe config Themes start= Demand
&sc.exe config DiagTrack start= Demand
&sc.exe config WbioSrvc start= Demand

## Clean Logs ##
wevtutil.exe el | Foreach-Object {wevtutil.exe cl "$_"}

## Clean Some Components of Windows Update ##

&Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
&Dism.exe /online /Cleanup-Image /SPSuperseded

## Delete Available Windows Features ##
Get-WindowsFeature | Where-Object {$_.InstallState -eq 'Available'} | Uninstall-WindowsFeature -Remove

## Defragmentation ##
Optimize-Volume -DriveLetter C -Defrag

## Zero Free Space ##
&.\sdelete64.exe -accepteula
&.\sdelete64.exe -nobanner -z c:
# &.\sdelete64.exe -acepteula -c c: