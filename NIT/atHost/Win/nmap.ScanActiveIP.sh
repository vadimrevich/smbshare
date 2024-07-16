#!/usr/bin/env sh
# *********************************************************
# nmap.ScanActiveIP.sh
# This script will find an IP addresses of active hosts
# in a range $1 with nmap ICNP method
#
# This script needs nmap and awk is installed
#
# In Some Networks it can make wrong results
# *********************************************************

# Set a Variable

aRange=$1

nmap -n -sn $aRange -oG - | awk '/Up$/{print $2}'
