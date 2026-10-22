#!/bin/bash
###########################################################
# test.nit.declarearray.sh
# This test script will declare two-dimensional
# associative array and give access to its elements.
#
# Members of Array:
# * No - an unique array element number. Must be Sequence
# * dev - an unique device name, FQDN or "nulled" if empty
# * ipv4 - an IP address of device or "0" if empty
# * mac - an MAC address of device or "00:00:00:00:00:00" if empty
#
# Array has name dev_array
#
###########################################################

declare -a dev_array
declare -a arr000
declare -a arr001
declare -a arr002
declare -a arr003

arr000=("0" "nulled" "0" "00-00-00-00-00-00" )
arr001=("1" "laptop-vg" "192.168.252.3" "A8-5E-45-D5-44-B3" )
arr002=("2" "server-home" "192.168.252.2" "00-00-00-00-00-00" )
arr003=("3" "raspberrypi" "192.168.252.4" "00-00-00-00-00-00" )

dev_array=()
dev_array+=(${arr000[@]})


# Run payload
for dev in "${dev_array[@]}"; 
do 
        echo "Device: ${dev[1]} has IP: ${dev[2]} and MAC: ${dev[3]}"; 
done
