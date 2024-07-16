# *******************************************************
# nit.get_netdiscovery.firewall.cmd
# This Script will Set Net Discover Firewall Rules
# *******************************************************
Get-NetFirewallRule -DisplayGroup "Network Discovery" -Enabled True -Action Allow -Direction Inbound
Get-NetFirewallRule -DisplayGroup "Обнаружение сети" -Enabled True -Action Allow -Direction Inbound
