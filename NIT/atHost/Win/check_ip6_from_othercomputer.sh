#!/usr/bin/env bash
###########################################################
# check_ip6_from_othercomputer.sh
# This Script will Check an IPv6 Address $2 from
# a Computer with IPv4 Address $1 and SSH User $3
###########################################################

#### Set Variables #####
COMPUTER="192.168.252.5"
ADDRESS6=$1
USER="vagrant"
PASS="0a9s8d7F"
SSHPORT=22

#### Run Payloads #####
ping -q -c 1 $COMPUTER
if [ $? -ne 0 ]; then
	echo "The Computer $COMPUTER is not Responded"
	exit 2
fi
sshpass -p $PASS ssh -p $SSHPORT $USER@$COMPUTER "/home/$USER/bin/check_ip6_from_thiscomputer.sh $ADDRESS6" | grep 'Success'
PING=$?
# PING=$(ping6 -c 1 $ADDRESS6%$IFACE | grep "100% packet loss" | cut -f1 -d' ')
if ((PING != 0 )); then
	echo "The IPv6 Address $ADDRESS6 is not Responded or an SSH Connection is not established"
	exit 1
fi
echo "Success PING6 Checks! The IPv6 Address $ADDRESS6 is Responded"
exit 0
