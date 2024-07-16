####
#

### Set a Variables

##### Set Time to Live
$aTimeToLive="00:05:00"

##### Set Zone Name
$aZone="peter.yuden.local"

##### Set Computers
##
### Set First Computer
#
$aName001="W7-AD"
$anIpv4001="192.168.252.126"

# Set Payloads
##

Add-DnsServerResourceRecordA -Name $aName001 -ZoneName $aZone -IPv4Address $anIpv4001 -TimeToLive $aTimeToLive



