####
#
# Get-NetworkPar00.ps1
# This Script Gets Network Parameters from Hyper-V Virtual Machines
#
###
Get-VM | Select -ExpandProperty NetworkAdapters | Select VMName, IPAddresses, Status
