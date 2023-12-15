$arangeIP = "192.168.252.0"
$rangeMask = 28

function Get-IPs000 {
    [CmdletBinding()]
    [OutputType([String])]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [String]
        $RangeIP,

        [Parameter(Mandatory = $true, Position = 1)]
        [Int]
        $CIDR
    )
    $wildcard = (32 - $CIDR)
    $ipb = [Net.IPAddress]::Parse($RangeIP).GetAddressBytes()
    [Array]::Reverse($ipb)
    $ip = [BitConverter]::ToInt32($ipb, 0)

    $theIps = @()

    For ($i = 1; $i -lt ((1 -shl $wildcard) - 1); $i++) {
        $ipi = ($ip -bor $i)
        $ipib = [BitConverter]::GetBytes($ipi)
        [Array]::Reverse($ipib)
        $Obj = New-Object IPAddress(@(,$ipib))
        $theIps += $Obj.IPAddressToString
    }
    return $theIps
}

Get-IPs000 $arangeIP $rangeMask
