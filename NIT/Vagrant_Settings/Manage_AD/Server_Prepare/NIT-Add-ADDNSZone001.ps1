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
$aName001="LAPTOP-VG"
$anIpv4001="192.168.252.3"

### Set Second Computer
#
$aName002="keenetic-giga"
$anIpv4002="192.168.252.1"

### Set Third Computer
#
$aName003="raspberrypi4"
$anIpv4003="192.168.252.5"

# Set Payloads
##

Add-DnsServerResourceRecordA -Name $aName001 -ZoneName $aZone -IPv4Address $anIpv4001 -TimeToLive $aTimeToLive
Add-DnsServerResourceRecordA -Name $aName002 -ZoneName $aZone -IPv4Address $anIpv4002 -TimeToLive $aTimeToLive
Add-DnsServerResourceRecordA -Name $aName003 -ZoneName $aZone -IPv4Address $anIpv4003 -TimeToLive $aTimeToLive




