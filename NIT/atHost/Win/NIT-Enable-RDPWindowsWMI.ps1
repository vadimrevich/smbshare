<#
.SYNOPSIS
    Tis Script will Enable RDP on Windows Computer
    %COMPUTERNAME0% via WMI
.DESCRIPTION
    Tis Script will Enable RDP on Windows Computer via WMI
.NOTES
    File name: NIT-Enable-RDPWindowsWMI.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2023-08-15
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2023-08-15) Script created
    1.0.1 - 
#>

# Name of a Computer is Checked (may be changed)
COMPUTERNAME0=localhost

# Check if RDP Connection on Computer is Enabled
Get-WmiObject -Class Win32_TerminalServiceSetting -Namespace root\CIMV2\TerminalServices -Computer $COMPUTERNAME0 -Authentication 6

# Enabling RDP on Checked Computer
(Get-WmiObject -Class Win32_TerminalServiceSetting -Namespace root\CIMV2\TerminalServices -Computer $COMPUTERNAME0 -Authentication 6).SetAllowTSConnections(1,1)

