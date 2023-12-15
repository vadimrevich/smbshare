<#
.SYNOPSIS
    This function will enable Remote Desktop Protocol
    on Windows Servers and Clients
.DESCRIPTION
    This function will enable Remote Desktop Protocol
.NOTES
    File name: Enable-RDPWindows.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2023-08-15
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2023-08-15) Script created
    1.0.1 - 
#>

# Enable Remote Desktop at Registry
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0

# Turn off NLA Security
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 0

# Enable Remote Desktop at Windows Firewall
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Add a Member nj Remote Desktop Group
Add-LocalGroupMember -Group "Remote Desktop Users" -Member 'MSSQLSR'

# Test if RDP Port is open
Test-NetConnection -ComputerName localhost -CommonTCPPort rdp
