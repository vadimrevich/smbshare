#!/usr/bin/env sh
##################################
# set-gateway-dns.kali.sh
# This Script will Register a Gateway and a DNS Servers
# at Linux Operation System
# ifconfig must be installed `sudo apt install net-tools`
# reslolvconf must be installed `sudo apt install resolvconf`
#################################

### Set Variables

aGATEWAY=172.25.32.1
a1stDNS=192.168.252.1 #Router
a2ndDNS=192.168.252.4
a3dDNS=8.8.8.8
aSearchDomain=yudenisov.internal

#### Run payloads

# Set Gateway
sudo route add default gw $aGATEWAY

# Set DNS

echo "nameserver $a1stDNS" >> /etc/resolv.conf
echo "nameserver $a2ndDNS" >> /etc/resolv.conf
echo "nameserver $a3dDNS"  >> /etc/resolv.conf
echo "search $aSearchDomain" >> /etc/resolv.conf

sudo resolvconf -u

### Check the Installation
route -n
cat /etc/resolv.conf
ping -c 4 $a1stDNS
ping -c 4 yandex.ru

