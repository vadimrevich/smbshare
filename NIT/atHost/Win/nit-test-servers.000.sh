#!/bin/bash
###########################################################
# test.nit.declarearray.sh
# This test script will declare array of devices and 
# check of their available
#
# Members of Array:
# * No - an unique array element number. Must be Sequence
# * dev - an unique device name, FQDN or "nulled" if empty
# * ipv4 - an IP address of device or "0" if empty
# * mac - an MAC address of device or "00:00:00:00:00:00" if empty
#
# Array has name array###
#
###########################################################

# Set variables
BINDIR=/home/vagrant/bin

if [ ! -e "$BINDIR/nit.check-devicecondition.000.sh" ]; then
	echo "$BINDIR/nit.check-devicecondition.000.sh is not found"
	exit 2
fi

declare -a arr000
declare -a arr001
declare -a arr002
declare -a arr003
declare -a arr004
declare -a arr005
declare -a arr006
declare -a arr007
declare -a arr008
declare -a arr009


arr000=("0" "nulled" "0" "00-00-00-00-00-00" )
arr001=("1" "laptop-vg" "192.168.252.3" "A8-5E-45-D5-44-B3" )
arr002=("2" "raspberrypi" "192.168.252.4" "b8:27:eb:54:e8:fd" )
arr003=("3" "raspberrypi4" "192.168.252.5" "e4:5f:01:a7:28:fc" )
arr004=("4" "MSI-SERVER" "192.168.252.12" "d8:43:ae:97:4a:fe" )
arr005=("5" "SERVER-HOME" "192.168.252.2" "78:ac:c0:88:55:fd" )
arr006=("6" "LAPTOP-EURTP" "192.168.252.8" "14:ac:60:56:da:4b" )
arr007=("7" "lin.netip4.ru" "185.189.12.199" "00-00-00-00-00-00" )
arr008=("8" "win.netip4.ru" "185.195.25.56" "00-00-00-00-00-00" )
arr009=("9" "secure.netip4.ru" "159.255.38.19" "00-00-00-00-00-00" )
arr010=("10" "KEENETIC-9335" "192.168.252.1" "50:ff:20:0d:c9:79" )


# Run payload

# arr000

$BINDIR/nit.check-devicecondition.000.sh ${arr000[0]} ${arr000[1]} ${arr000[2]} ${arr000[3]}
if [ $? -eq 0 ]; then
	echo "Device: ${arr000[1]} has IP: ${arr000[2]} and MAC: ${arr000[3]}"; 
fi

# arr001

$BINDIR/nit.check-devicecondition.000.sh ${arr001[0]} ${arr001[1]} ${arr001[2]} ${arr001[3]}
if [ $? -eq 0 ]; then
	echo "Device: ${arr001[1]} has IP: ${arr001[2]} and MAC: ${arr001[3]}"; 
fi

# arr002

$BINDIR/nit.check-devicecondition.000.sh ${arr002[0]} ${arr002[1]} ${arr002[2]} ${arr002[3]}
if [ $? -eq 0 ]; then
	echo "Device: ${arr002[1]} has IP: ${arr002[2]} and MAC: ${arr002[3]}"; 
fi

# arr003

$BINDIR/nit.check-devicecondition.000.sh ${arr003[0]} ${arr003[1]} ${arr003[2]} ${arr003[3]}
if [ $? -eq 0 ]; then
	echo "Device: ${arr003[1]} has IP: ${arr003[2]} and MAC: ${arr003[3]}"; 
fi

# arr004

$BINDIR/nit.check-devicecondition.000.sh ${arr004[0]} ${arr004[1]} ${arr004[2]} ${arr004[3]}
if [ $? -eq 0 ]; then
	echo "Device: ${arr004[1]} has IP: ${arr004[2]} and MAC: ${arr004[3]}"; 
fi

# arr005

$BINDIR/nit.check-devicecondition.000.sh ${arr005[0]} ${arr005[1]} ${arr005[2]} ${arr005[3]}
if [ $? -eq 0 ]; then
	echo "Device: ${arr005[1]} has IP: ${arr005[2]} and MAC: ${arr005[3]}"; 
fi

# arr006

$BINDIR/nit.check-devicecondition.000.sh ${arr006[0]} ${arr006[1]} ${arr006[2]} ${arr006[3]}
if [ $? -eq 0 ]; then
	echo "Device: ${arr006[1]} has IP: ${arr006[2]} and MAC: ${arr006[3]}"; 
fi

# arr007

$BINDIR/nit.check-devicecondition.000.sh ${arr007[0]} ${arr007[1]} ${arr007[2]} ${arr007[3]}
if [ $? -eq 0 ]; then
	echo "Device: ${arr007[1]} has IP: ${arr007[2]} and MAC: ${arr007[3]}"; 
fi

# arr008

$BINDIR/nit.check-devicecondition.000.sh ${arr008[0]} ${arr008[1]} ${arr008[2]} ${arr008[3]}
if [ $? -eq 0 ]; then
	echo "Device: ${arr008[1]} has IP: ${arr008[2]} and MAC: ${arr008[3]}"; 
fi

# arr009

$BINDIR/nit.check-devicecondition.000.sh ${arr009[0]} ${arr009[1]} ${arr009[2]} ${arr009[3]}
if [ $? -eq 0 ]; then
	echo "Device: ${arr009[1]} has IP: ${arr009[2]} and MAC: ${arr009[3]}"; 
fi

# arr010

$BINDIR/nit.check-devicecondition.000.sh ${arr010[0]} ${arr010[1]} ${arr010[2]} ${arr010[3]}
if [ $? -eq 0 ]; then
	echo "Device: ${arr010[1]} has IP: ${arr010[2]} and MAC: ${arr010[3]}"; 
fi

