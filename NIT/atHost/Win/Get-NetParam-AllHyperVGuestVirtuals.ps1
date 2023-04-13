###
#
# Get-NetParam-AllHyperVGuestVirtuals.ps1
# This Script Print Network Parameters for All Running Guest Hyper-V Virtual Machines
##
get-vm | ?{$_.State -eq "Running"} | select -ExpandProperty networkadapters | select vmname, macaddress, switchname, ipaddresses | ft -wrap -autosize
