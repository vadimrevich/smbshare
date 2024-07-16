#!/usr/bin/env bash
###########################################################
# check_ip6_from_othercomputer.sh
# This Script will Check an IPv6 Address $2 from
# a Computer with IPv4 Address $1 and SSH User $3
###########################################################

#### Set Variables #####
ADDRESS6=$1
IFACE="eth0"

#### Run Payloads ####
#
ping6 -c 1 -q $ADDRESS6%$IFACE
PING=$?
if ((PING != 0)); then
    echo "Error! The IPv6 address $ADDRESS6 is not reachable."
    exit 1
else
    echo "Success! The IPv6 addrss $ADDRESS6 is reachable."
    exit 0
fi
 

