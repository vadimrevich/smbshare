###########################################################
# Test-NetWork.Nodes.000.psm1
# This Script will Check a Network
# for Opened Nodes
###########################################################

###################
# Initial Data
# Must be Changed
###################

$aNums = 1..20 # Last 8 bit of IP Address
$NetworkNumC="192.168.252." # A C Network Path of IP Address

function Get-Mac-NIT( $IPAddr ) {
    $MACPattern='([0-9A-Fa-f]{2}[:\-]){5}([0-9A-Fa-f]{2})'
    $NILMAC="FF:FF:FF:FF:FF:FF"
    $MAC01 = arp -a | Select-String $IPAddr
    if( $MAC01 -eq $null ) {
        $aMac01 = ""
    }
    else {
        # $aMac01 = ($MAC01 | Select-String -Pattern $MACPattern ).Matches[0].Value
        $aMac01 = $MAC01[0].ToString()

        $aMac01 = $aMac01 -replace '(^\s+|\s+$)','' -replace '\s+',' '
        $aMac01 = $aMac01.Split(' ')[1]
        $aMac01 = $aMac01 -replace "\-", ":"
    }
    # 
    
    
    
    $iRes = Test-NetConnection $anIP -port 135 -InformationLevel Quiet
    if( $iRes -eq $true ) {
        $MAC02 = (gwmi -ComputerName $IPAddr -Class Win32_NetworkAdapterConfiguration | where {$_.IPAddress -like $IPAddr}).MACAddress
    }
    else {
        $MAC02 = $null
    }
        if( $MAC02 -eq $null ) {
            $aMac02 = ""
        }
        else {
            $aMac02 = $MAC02.ToString()
        }
    $aMac02= $aMac02 -replace "\-", ":"
    if( $aMac02.Length -gt 0) {
        $aMac02
    }
    else {
        if( $aMac01 -gt 0 ) {
            $aMac01
        }
        else {
            $NILMAC
        }

    }
    
}

function Nmap-PartC( $NetworkNum, $aNums ) {
$IPNodes = @()
$aNums | ForEach-Object {
    $anIP = $NetworkNum + $_.ToString()
    $iRes = Test-Connection -ComputerName $anIP -Count 2 -Quiet

    if( $iRes -eq $True ) {
        $MAC = Get-Mac-NIT( $anIP )
        Try {
            $anFQDN = [System.Net.DNS]::GetHostByAddress( $anIP ).HostName
        }
        Catch {
            $anFQDN = ""
        }
        if( $anFQDN.Length -gt 0 ) {
            $aCompName = $anFQDN.Split('.')[0]
            $aDomain = $anFQDN -replace "$aCompName.",""
        }
        else {
            $aCompName = ""
            $aDomain = ""
        }
        Try {
            $aDNS = (Resolve-DnsName $anIP).NameHost
        }
        Catch {
            $aDNS = ""
        }

        $anObj = New-Object -TypeName PSObject -Property @{ DestIP = $anIp; Status = "Enabled"; DestHostName = $aDNS ; DestName = $aCompName; DestDomain = $aDomain; DestMAC = $MAC }
        $IPNodes += $anObj
    }
    else {
        # $anObj = New-Object -TypeName PSObject -Property @{ DestIP = $anIp; Status = "Disabled"; DestHostName = ""; DestName = ""; DestDomain = ""; DestMAC = "FF:FF:FF:FF:FF:FF"  }
        # $IPNodes += $anObj
    }
}
$IPNodes
}

function Nmap-IPList( $IPList ) {
$IPNodes = @()
$IPList | ForEach-Object {
    $anIP = $_.ToString()
    $iRes = Test-Connection -ComputerName $anIP -Count 2 -Quiet

    if( $iRes -eq $True ) {
        $MAC = Get-Mac-NIT( $anIP )
        Try {
            $anFQDN = [System.Net.DNS]::GetHostByAddress( $anIP ).HostName
        }
        Catch {
            $anFQDN = ""
        }
        if( $anFQDN.Length -gt 0 ) {
            $aCompName = $anFQDN.Split('.')[0]
            $aDomain = $anFQDN -replace "$aCompName.",""
        }
        else {
            $aCompName = ""
            $aDomain = ""
        }
        Try {
            $aDNS = (Resolve-DnsName $anIP).NameHost
        }
        Catch {
            $aDNS = ""
        }

        $anObj = New-Object -TypeName PSObject -Property @{ DestIP = $anIp; Status = "Enabled"; DestHostName = $aDNS ; DestName = $aCompName; DestDomain = $aDomain; DestMAC = $MAC }
        $IPNodes += $anObj
    }
    else {
        # $anObj = New-Object -TypeName PSObject -Property @{ DestIP = $anIp; Status = "Disabled"; DestHostName = ""; DestName = ""; DestDomain = ""; DestMAC = "FF:FF:FF:FF:FF:FF"  }
        # $IPNodes += $anObj
    }
}
$IPNodes
}

function Sort-IPArray( $array ) {
    $array1 = $array | sort {[Version]$_}
    $array1 | Select-Object -Unique
}

function Filter-IPArray-Special( $array ) {
    $array1 = @()
    $nCount = $array.Count - 1
    0..$nCount | ForEach-Object {
        if( $array[$_].StartsWith("127.") -eq $false ) {
            if( $array[$_].StartsWith("169.254.") -eq $false ) {
                if( $array[$_].StartsWith("224.0.0.") -eq $false ) {
                    if( $array[$_].StartsWith("239.255.") -eq $false ) {
                        if( $array[$_].StartsWith("255.") -eq $false ) {
                            if( $array[$_].StartsWith("0.0.0.0") -eq $false ) {
                                $array1 += $array[$_]
                            }
                        }
                    }
                }
            }
        }
    }
    $array1
}

function Get-ArpIP {
    $IPNodes = @()
    $IPPattern = "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
    $ArpOutput= arp -a | Out-String -Stream | Select-String -Pattern $IPPattern
    $mc = [regex]::matches($ArpOutput, $IPPattern)
    $mcNum = $mc.Groups.Count - 1
    0..$mcNum | ForEach-Object {
        $IPNodes += $mc[$_].Value
    }
    $array1 = Sort-IPArray $IPNodes
    Filter-IPArray-Special $array1
}

function Nmap-PartC-SmbShare( $NetworkNum, $aNums ) {
    $IPNodes = @()
    $anIPs = @()
    $aNums | ForEach-Object {
        $anIP = $NetworkNum + $_.ToString()
        $iRes = Test-NetConnection $anIP -port 139 -InformationLevel Quiet

        if( $iRes -eq $True ) {
            $anIPs += $anIP
        }
    }
    $aNums | ForEach-Object {
        $anIP = $NetworkNum + $_.ToString()
        $iRes = Test-NetConnection $anIP -port 445 -InformationLevel Quiet

        if( $iRes -eq $True ) {
            $anIPs += $anIP
        }
    }
    $array1 = Sort-IPArray $anIPs
    # $array1
    $array2 = Filter-IPArray-Special $array1
    $array2 | ForEach-Object {
        $anIP = $_.ToString()
        $MAC = Get-Mac-NIT( $anIP )
        Try {
            $anFQDN = [System.Net.DNS]::GetHostByAddress( $anIP ).HostName
        }
        Catch {
            $anFQDN = ""
        }
        if( $anFQDN.Length -gt 0 ) {
            $aCompName = $anFQDN.Split('.')[0]
            $aDomain = $anFQDN -replace "$aCompName.",""
        }
        else {
            $aCompName = ""
            $aDomain = ""
        }
        Try {
            $aDNS = (Resolve-DnsName $anIP).NameHost
        }
        Catch {
            $aDNS = ""
        }

        $anObj = New-Object -TypeName PSObject -Property @{ DestIP = $anIp; SmbStatus = "Enabled"; DestHostName = $aDNS ; DestName = $aCompName; DestDomain = $aDomain; DestMAC = $MAC }
        $IPNodes += $anObj
    }
    $IPNodes
}


### Run Payload

Nmap-PartC-SmbShare $NetworkNumC $aNums