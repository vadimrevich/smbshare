#!/usr/bin/env bash
###########################################################
# check-sysinfo.0.online.sh
# This Script will Check Main Host Details such us
# a hostname, Current User, IP address,
# External IP Address, Gateway, Name of System, Redaction
#
# PARAMETERS:   NONE
# RETURN:       0 if Success Run Script
#               1 if Check System Integrity Error
#               17 if Run a non Root User
#
# Location: http://file.netip4.ru:80/LINSCRIPTS/NIT/BHSH/check-sysinfo/check-sysinfo.0.online.sh
####

#### Set Variables ####
###

### Set Metadata ###
#

PACKAGES_DIR=packages
PRODUCTNAME=BHSH
SUBPRODUCTNAME=check-sysinfo
FIRM_NAME=NIT

### Set Output File
aHOSTNAME=$(hostname)
aCURRENTUSER=$USER
anEXT_IPV4_ADDR=$(curl -s http://whatismijnip.nl | cut -d ' ' -f 5)
anOutputFile=$SUBPRODUCTNAME.0.$aCURRENTUSER.$aHOSTNAME.$anEXT_IPV4_ADDR.log

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

### Set Host
http_pref="http"
http_domain="file.netip4.ru"
http_port="80"
remote_dir00="/LINSCRIPTS/$FIRM_NAME/$PRODUCTNAME/$SUBPRODUCTNAME/"
host00=$http_pref://$http_domain:$http_port$remote_dir00

### Make Directory
aDIR=$HOME/packages/$FIRM_NAME/$PRODUCTNAME

if [ ! -d "$aDIR" ]; then
	mkdir -p $aDIR
fi
cd $aDIR

if [ ! -d "$aDIR" ]; then
	echo "Error! Directory $aDir is not found!"
	exit 1
fi

aName000="check-sysinfo.0.online.sh"
aName02="linux.health-check.online.sh"
aName01="linux.system-check.online.sh"
aName03="host.main.details.sh"
OutFileName=$anOutputFile

# Run payload

if [ -f "$aDIR/$aName01" ]; then
	rm $aDIR/$aName01
fi

if [ -f "$aDIR/$aName02" ]; then
	rm $aDIR/$aName02
fi

if [ -f "$aDIR/$aName03" ]; then
	rm $aDIR/$aName03
fi

cd $aDIR

wget $host00$aName01
wget $host00$aName02
wget $host00$aName03

echo "a System Info:" > $aDIR/$OutFileName
/bin/bash $aDIR/$aName02 >> $aDIR/$OutFileName
/bin/bash $aDIR/$aName01 >> $aDIR/$OutFileName
sudo /bin/bash $aDIR/$aName03 | tee -a $aDIR/$OutFileName

cat $aDIR/$OutFileName

## End
cd $SCRIPT_DIR
exit 0
