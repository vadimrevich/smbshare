###########################################################
# Get-NetworkPar.ps1
# This Script Gets Network Parameters of Hyper-V Guests
###########################################################

get-vm | select -ExpandProperty networkadapters | select vmname, macaddress, switchname, ipaddresses
