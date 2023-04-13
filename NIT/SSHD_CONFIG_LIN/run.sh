#!/usr/bin/env bash
# *******************************************************
# ssh_original_config_change.sh
# This Script Changes the Original 
# /etc/ssh/sshd_config file:
# * Change port to $1
# * Add Insecure Vagrant Keys
# * Add Powershell SSH Subsystem
# * Make other Insecure Settings
#
# PARAMETERS:	$1 is a New Listen Port of SSH (22 is Default)
# RETURNS:	0 if Success Run
# 		16 if Check Integrity Failed
#		17 if Runs without Sudo
#
# *******************************************************

# Check if script run at root mode
#

if [ $EUID -ne 0 ]; then
	echo "ERROR: process must be start with root permissions"
	exit 17
fi

echo Run as Admin...

# Set Metadata

PRODUCT_NAME=SSHD_CONFIG_LIN
FIRM_NAME=NIT

echo Set Environments Settings...
#
WORKINGPATH=/etc/ssh
UTIL=/usr/bin
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Test
WORKINGPATH=$SCRIPT_DIR/ssh_test

echo Set Programs...
CURLEXE=$UTIL/curl

echo Set Files...
#
rsaprivkey=vagrant
rsapubkey=vagrant.pub
ssgconfchange=ssh_config_change.sed.txt

echo Check Integrity...
#
if [ ! -f $WORKINGPATH/sshd_config ]; then
	echo $WORKINGPATH/sshd_config not found 
	exit 16
fi
if [ ! -f $UTIL/sed ]; then 
	echo $UTIL/sed not found 
	exit 16
fi
if [ ! -f $CURLEXE ]; then
	echo $CURLEXE not found 
	exit 16
fi

if [ ! -f $UTIL/sed ]; then
	echo $UTIL/sed not found 
	exit 16
fi

# Set Remote Folders
#
http_BaseDir01=/PROGS/
http_ProgDir01=$http_BaseDir01$FIRM_NAME/$PRODUCT_NAME/

# Hosts
#
http_pref01=http
http_host01=file.netip4.ru
http_port01=80
#
echo Set Hosts...
#
host01=$http_pref01://$http_host01:$http_port01$http_ProgDir01

echo Create Backup Copy $WORKINGPATH\sshd_config...
#
if [ -f $WORKINGPATH/sshd_config.bak ]; then
	rm -v $WORKINGPATH/sshd_config.bak
fi
cp -v $WORKINGPATH/sshd_config $WORKINGPATH/sshd_config.bak

echo Check Ports Parameter...
#
ListenPort=$1
if [ -z "$1" ]; then 
	ListenPort=22
fi 
echo ListenPort = $ListenPort

echo Download Vagrant Keys...
#
$CURLEXE $host01$rsaprivkey -o $WORKINGPATH/ssh_host_rsa_key
$CURLEXE $host01$rsapubkey -o $WORKINGPATH/ssh_host_rsa_key.pub
$CURLEXE $host01$ssgconfchange -o $SCRIPT_DIR/$ssgconfchange
mkdir ~/.ssh/
$CURLEXE $host01%rsapubkey% >> ~/.ssh/authorized_keys

echo Prepare sshd_config
SED_Exchange="s/^\#Port 22/Port $ListenPort/"
# echo SED_Exchange = $SED_Exchange
$UTIL/sed -f $SCRIPT_DIR/$ssgconfchange $WORKINGPATH/sshd_config > $WORKINGPATH/sshd_config.1
$UTIL/sed -e "$SED_Exchange" $WORKINGPATH/sshd_config.1 > $WORKINGPATH/sshd_config
rm -v $WORKINGPATH/sshd_config.1

echo Fix sshd...
find $WORKINGPATH -type f -exec chown root:root '{}' \;
find $WORKINGPATH -type f -exec chmod 0644 '{}' \;
find $WORKINGPATH -type f -name 'ssh_host_*' -exec chmod 0600 '{}' \;
# service ssh restart

echo The Success End of the Script
exit 0
