<#
.SYNOPSIS
    Get All Windows Network Interfaces
.DESCRIPTION
    Get All Windows Network Interfaces
    on Windows 10.0 Local Computer
.NOTES
    File name: NIT-Get-InterfaceNames.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2024-10-05
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-10-05) Script created
    1.0.1 - 
#>

### Set Variables
#


### Set a Function
#
function Get-Interfaces-00 {
    $interfaces = Get-WmiObject Win32_NetworkAdapter

    # Loop for each  an Interface
    $Objects = foreach($anInterface in $interfaces) {
        $friendlyname = $anInterface | Select-Object -ExpandProperty NetConnectionID
        $name = $anInterface.GetRelated("Win32_PnPEntity") | Select-Object -ExpandProperty Name
        $anIndex = $anInterface | Select-Object -ExpandProperty Index
        $query01 = "SELECT * FROM Win32_NetworkAdapterConfiguration WHERE Index = " + $anIndex
        $anInterfaceConf = Get-WmiObject -Query $query01
        $anIPV4 = $anInterfaceConf | Select-Object -ExpandProperty IPAddress | Select-Object -First 1
        $aDefaultGateway = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty DefaultIPGateway | Select-Object -First 1
        $anIPv4Subnet = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty IPSubnet | Select-Object -First 1
        $aLocalLinkIPv6 = $anInterfaceConf | Select-Object -ExpandProperty IPAddress | Select-Object -Index 1
        $aLocalLinkGateway = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty DefaultIPGateway | Select-Object -Index 1
        $aLocalLinkSubnet = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty IPSubnet | Select-Object -index 1
        $aGlobalLinkIPv6 = $anInterfaceConf | Select-Object -ExpandProperty IPAddress | Select-Object -Index 2
        $aGlobalLinkGateway = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty DefaultIPGateway | Select-Object -Index 2
        $aGlobalLinkSubnet = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty IPSubnet | Select-Object -Index 2
        $aMACAddress = $anInterfaceConf | Select-Object -ExpandProperty MACAddress
        # This tests to ensure friendlyname isn't null
            # "$friendlyname is $name"
            $ObjectProperties = @{
                IPv4Address = $anIPV4
                IPv4Subnet = $anIPv4Subnet
                IPv4Gateway = $aDefaultGateway
                IPv6Local = $aLocalLinkIPv6
                IPv6LocalSubnet = $aLocalLinkSubnet
                IPv6LocalGateway = $aLocalLinkGateway
                IPv6Global = $aGlobalLinkIPv6
                IPv6GlobalSubnet = $aGlobalLinkSubnet
                IPv6GlobalGateway = $aGlobalLinkGateway
                Name = $name
                FrendlyName = $friendlyname
                MACAddress = $aMACAddress
                Index = $anIndex
            }

            # Now create an object. 
            # When we just drop it in the pipeline like this, it gets assigned to $Objects
            New-Object psobject -Property $ObjectProperties
    }
    return $Objects
}

function Get-Interfaces-01 {
    $interfaces = Get-WmiObject Win32_NetworkAdapter

    # Loop for each  an Interface
    $Objects = foreach( $anInterface in $interfaces) {
        $friendlyname = $anInterface | Select-Object -ExpandProperty NetConnectionID
        $name = $anInterface.GetRelated("Win32_PnPEntity") | Select-Object -ExpandProperty Name
        $anIndex = $anInterface | Select-Object -ExpandProperty Index
        $query01 = "SELECT * FROM Win32_NetworkAdapterConfiguration WHERE Index = " + $anIndex
        $anInterfaceConf = Get-WmiObject -Query $query01
        $anIPV4 = $anInterfaceConf | Select-Object -ExpandProperty IPAddress | Select-Object -First 1
        $aDefaultGateway = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty DefaultIPGateway | Select-Object -First 1
        $anIPv4Subnet = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty IPSubnet | Select-Object -First 1
        $aLocalLinkIPv6 = $anInterfaceConf | Select-Object -ExpandProperty IPAddress | Select-Object -Index 1
        $aLocalLinkGateway = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty DefaultIPGateway | Select-Object -Index 1
        $aLocalLinkSubnet = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty IPSubnet | Select-Object -index 1
        $aGlobalLinkIPv6 = $anInterfaceConf | Select-Object -ExpandProperty IPAddress | Select-Object -Index 2
        $aGlobalLinkGateway = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty DefaultIPGateway | Select-Object -Index 2
        $aGlobalLinkSubnet = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty IPSubnet | Select-Object -Index 2
        $aMACAddress = $anInterfaceConf | Select-Object -ExpandProperty MACAddress
        # This tests to ensure friendlyname isn't null
        if($friendlyname){
            # "$friendlyname is $name"
            $ObjectProperties = @{
                IPv4Address = $anIPV4
                IPv4Subnet = $anIPv4Subnet
                IPv4Gateway = $aDefaultGateway
                IPv6Local = $aLocalLinkIPv6
                IPv6LocalSubnet = $aLocalLinkSubnet
                IPv6LocalGateway = $aLocalLinkGateway
                IPv6Global = $aGlobalLinkIPv6
                IPv6GlobalSubnet = $aGlobalLinkSubnet
                IPv6GlobalGateway = $aGlobalLinkGateway
                Name = $name
                FrendlyName = $friendlyname
                MACAddress = $aMACAddress
                Index = $anIndex
            }

            # Now create an object. 
            # When we just drop it in the pipeline like this, it gets assigned to $Objects
            New-Object psobject -Property $ObjectProperties
        }
    }
    return $Objects
}

function Get-PhysicalInterfaces {
    $query = "SELECT * FROM Win32_NetworkAdapter WHERE Manufacturer != 'Microsoft' AND NOT PNPDeviceID LIKE 'ROOT\\%'"
    $interfaces = Get-WmiObject -Query $query | Sort index

    # Loop for each  an Interface
    $Objects = ForEach($anInterface in $interfaces){
        $friendlyname = $anInterface | ForEach-Object { $anInterface.NetConnectionID }
        $name = $anInterface.GetRelated("Win32_PnPEntity") | Select-Object -ExpandProperty Name
        $anIndex = $anInterface | Select-Object -ExpandProperty Index
        $query01 = "SELECT * FROM Win32_NetworkAdapterConfiguration WHERE Index = " + $anIndex
        $anInterfaceConf = Get-WmiObject -Query $query01
        $anIPV4 = $anInterfaceConf | Select-Object -ExpandProperty IPAddress | Select-Object -First 1
        $aDefaultGateway = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty DefaultIPGateway | Select-Object -First 1
        $anIPv4Subnet = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty IPSubnet | Select-Object -First 1
        $aLocalLinkIPv6 = $anInterfaceConf | Select-Object -ExpandProperty IPAddress | Select-Object -Index 1
        $aLocalLinkGateway = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty DefaultIPGateway | Select-Object -Index 1
        $aLocalLinkSubnet = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty IPSubnet | Select-Object -index 1
        $aGlobalLinkIPv6 = $anInterfaceConf | Select-Object -ExpandProperty IPAddress | Select-Object -Index 2
        $aGlobalLinkGateway = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty DefaultIPGateway | Select-Object -Index 2
        $aGlobalLinkSubnet = $anInterfaceConf | ?{$_.IPEnabled} | Select-Object -ExpandProperty IPSubnet | Select-Object -Index 2
        $aMACAddress = $anInterfaceConf | Select-Object -ExpandProperty MACAddress
        # This tests to ensure friendlyname isn't null
        if($friendlyname){
            # "$friendlyname is $name"
            $ObjectProperties = @{
                IPv4Address = $anIPV4
                IPv4Subnet = $anIPv4Subnet
                IPv4Gateway = $aDefaultGateway
                IPv6Local = $aLocalLinkIPv6
                IPv6LocalSubnet = $aLocalLinkSubnet
                IPv6LocalGateway = $aLocalLinkGateway
                IPv6Global = $aGlobalLinkIPv6
                IPv6GlobalSubnet = $aGlobalLinkSubnet
                IPv6GlobalGateway = $aGlobalLinkGateway
                Name = $name
                FrendlyName = $friendlyname
                MACAddress = $aMACAddress
                Index = $anIndex
            }

            # Now create an object. 
            # When we just drop it in the pipeline like this, it gets assigned to $Objects
            New-Object psobject -Property $ObjectProperties
        }
    }
    return $Objects
}

### Run Payloads
#
Get-PhysicalInterfaces
