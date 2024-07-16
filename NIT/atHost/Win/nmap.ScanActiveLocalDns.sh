#!/usr/bin/env sh
# *******************************************************
# nmap.ScanActiveLocalDns.cmd
# This Script will Find DNS Names with IP Addresses
# on Local Network with Range $1
#
# This Script needs that nmap, sed and awk
# have been installed
#
# In Some Networks it can make wrong results
# *******************************************************

# Set a Variable

aRange=$1

# Run payload
#
nmap -sn $aRange | grep "^Nmap scan" | sed -e 's/^Nmap scan report for //g' | sed -e 's/\(.*\)(\(.*\))/\2 \1/g' | awk -F ' ' '($2 != "")'
