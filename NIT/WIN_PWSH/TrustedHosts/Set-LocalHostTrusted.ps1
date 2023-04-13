###
#
# Set-AllHostTrusted.ps1
# This Script Make all Local Hosts
# Trusted for WinRM Operations
# Be Carefully to Use!
#
##

Set-Item wsman:localhost\client\trustedhosts -value "<local>"
