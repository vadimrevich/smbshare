# *******************************************************
# nit.set_netdiscovery.service.cmd
# This Script will Set a Net Discover Services
# *******************************************************
Get-Service fdPHost,FDResPub | Set-Service  -startuptype automatic -passthru | Start-Service
Restart-Computer -Force
