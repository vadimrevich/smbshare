###
#
# Get-IPAddresses-AllHyperVGuestVirtuals.ps1
# This Script Print Network IP Adresses (IPv4, IPv6) for All Running Guest Hyper-V Virtual Machines
##
get-vm | ?{$_.State -eq "Running"} | select -ExpandProperty networkadapters | select -ExpandProperty ipaddresses | ft -wrap -autosize
