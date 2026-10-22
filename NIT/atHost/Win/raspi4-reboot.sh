#!/usr/bin/env bash
# *******************************************************
# server-reboot
# This Script will Shutdown a server-home Server
# with help of Command Line
# *******************************************************

# Set Path

VMNAME=raspberrypi4.yudenisov.internal
VMUSER=vagrant
VMPASS=0a9s8d7F
VMSSHPORT=22

# Run Payloads
ping -c 2 -4 $VMNAME > /dev/null 2> /dev/null

if [ $? -ne 0 ]; then
    echo "Cannot connect to $VMNAME. Ping Error."
    exit 2
fi

ssh -p $VMSSHPORT -4 $VMUSER@$VMNAME "sudo reboot"

if [ $? -ne 0 ]; then
    echo "Cannot connect to $VMNAME. Connection not established."
    exit  2
fi
exit 0
