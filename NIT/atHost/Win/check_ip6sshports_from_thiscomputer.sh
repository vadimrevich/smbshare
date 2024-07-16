#!/usr/bin/env bash
###########################################################
# check_ip6sshport_from_thiscomputer.sh
# This Script will Check an SSH Port at IPv6 Address $2
###########################################################

#### Set Variables #####
ADDRESS6=$1
IFACE="eth0"
SSHPORT=22

#### Run Payloads ####
#
#ping6 -c 1 -q $ADDRESS6%$IFACE
nmap -Pn -p $SSHPORT -6 $ADDRESS6 | grep 'open'
PING=$?
if ((PING != 0)); then
    echo "Error! The IPv6 address $ADDRESS6 is not reachable."
    exit 1
else
    echo "Success! The IPv6 addrss $ADDRESS6 is reachable."
    exit 0
fi
 

