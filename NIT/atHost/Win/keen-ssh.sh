#!/usr/bin/env bash
# *******************************************************
# keen-ssh.bat
# This Script will Connect to a Virtual Machine 
# *******************************************************

# set a variables
# 
VMNAME=KEENETIC-9335.yudenisov.internal
VMUSER=admin
VMPASS=0a9s8d7F
VMSSHPORT=55022

# Run Payloads
ping -c 2 -4 $VMNAME > /dev/null 2> /dev/null

if [ $? -ne 0 ]; then
    echo "Cannot connect to $VMNAME. Ping Error."
    exit 2
fi

ssh -p $VMSSHPORT -4 $VMUSER@$VMNAME

if [ $? -ne 0 ]; then
    echo "Cannot connect to $VMNAME. Connection not established."
    exit  2
fi
exit 0
