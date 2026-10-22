#!/usr/bin/env bash
###########################################################
# linux.health-check.online.sh
# This Script will Check Main Host Details such us
# a hostname, Current User, IP address,
# External IP Address, Gateway, Name of System, Redaction
#
# PARAMETERS:   NONE
# RETURN:       0 if Success Run Script
#               1 if Check System Integrity Error
#               17 if Run a non Root User
####

#### Set Variables ####
###

### Set Metadata ###
#

PACKAGES_DIR=packages
PRODUCTNAME=BHSH
SUBPRODUCTNAME=linux.system-check.online
FIRM_NAME=NIT

if [ ! -e /usr/bin/id ]; then
    echo "/usr/bin/id is not found."
    echo "The Packet coreutils may be corrupt!"
    echo "Please check error and reinstall your distributive."
    exit 1
fi

### Set an NIT Users Variable ###
#
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "### Check System Integrity ###"
###
if [ ! -f /etc/os-release ]; then
    echo "/etc/os-release is not found"
    exit 1
fi

if [ ! -e /bin/bash ]; then
    echo "/bin/bash is not found"
    exit 1
fi

if [ ! -e /usr/bin/wget ]; then
    echo "/usr/bin/wget is not found"
    exit 1
fi

### Make Directory
aDIR=$HOME/packages/$FIRM_NAME/$PRODUCTNAME

if [ ! -d "$aDIR" ]; then
	mkdir -p $aDIR
fi
cd aDIR

if [ ! -d "$aDIR" ]; then
	echo "Error! Directory $aDir is not found!"
	exit 1
fi

aName=health-check.sh

# Run payload

if [ -f "$aDIR/$aName" ]; then
	rm $aDIR/$aName
fi

cd $aDIR

wget https://github.com/SimplyLinuxFAQ/health-check-script/raw/refs/heads/master/health-check.sh

/bin/bash $aDIR/$aName | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g"

## End
cd $SCRIPT_DIR
exit 0
