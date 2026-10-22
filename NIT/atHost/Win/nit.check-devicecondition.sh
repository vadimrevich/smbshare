#!/bin/bash
###########################################################
# nit.check-devicecondition.sh
# The script will check a device conditions
# and print result
###########################################################

# Set variables
BINDIR=/home/vagrant/bin

# Check a number of parameters

if [ "$#" -ne 4 ];
then
    echo "Usage: $0 <number> <device name> <ipv4 address> <mac address>" >&2; exit 2
fi

# Check IP Address
# if [ ! -e "$BINDIR/check-ip-addresses.sh" ]; then echo "File $BINDIR/check-ip-addresses.sh not found"; exit 2; fi
ipv4=$(echo $3 | grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)")
if [ "$ipv4" == "" ]; then echo "IPv4 address $3 is not valid"; exit 2; fi 
if [ "$ipv4" == "0.0.0.0" ]; then echo "IPv4 address $ipv4 is not valid"; exit 1; fi

# Chec MAC Address
# if [ ! -e "$BINDIR/check-mac-addresses.sh" ]; then echo "File $BINDIR/check-mac-addresses.sh not found"; exit 2; fi
aMac=$(echo $4 | grep -E -o "((([0-9a-fA-F]{2})[ :-]){5}[0-9a-fA-F]{2})|(([0-9a-fA-F]){6}[:-]([0-9a-fA-F]){6})|([0-9a-fA-F]{12})")
if [ "$aMac" == "" ]; then echo "Mac address $4 is not valid"; exit 2; fi 
aMac=$(echo $aMac | tr "=-" ":")
if [ "$aMac" == "00:00:00:00:00:00" ]; then echo "Mac address $aMac is empty"; fi

# Check number
var=$1
if [[ $var =~ ^[0-9]+$ ]]; then num=$var; else echo "Number of sequence is not valid"; exit 2; fi

# Check Device
device=$2
if [ "$device" == "null" ]; then echo "Device name is not valid"; device="dev_$num"; fi

# Run payload
if [ "$2" == "null" ]; then
    if [ "$ipv4" == "127.0.0.1" ]; then 
        if [ "$aMac" == "00:00:00:00:00:00" ]; then
            echo "The Device is empty"
            exit 1
        fi
    fi
fi
ping -c 1 $ipv4 > /dev/null 2>&1
if [ $? -ne 0 ]; then echo "Device: $device is not available"; exit 1; fi
echo "Device: $device has IP: $ipv4 and MAC: $aMac"
exit 0




