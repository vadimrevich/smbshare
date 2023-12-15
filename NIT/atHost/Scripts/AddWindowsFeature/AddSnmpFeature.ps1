Get-WindowsCapability -Online | Where-Object {$_.Name -match "SNMP"} | Add-WindowsCapability -Online

Get-WindowsCapability -Online -Name "SNMP*"

