#!/usr/bin/env bash
#####################
# frp.install-home.test.smbclient.amd64.sh
# This Script will Download and Install frp Reverse Proxy
# at Linux Computer
#
# PARAMETERS: no
####################

# Set Metadata
#
FIRM_NAME=NIT
PRODUCT_NAME=frp
PRODUCT_CATEGORY=Reverse-proxy
PRODUCT_NAME_FOLDER=home.test
PRODUCT_SOURCE_URL=//192.168.252.3/yuden
LOGINSTRING=LAPTOP-VG/yuden%P@ssp0rtSaratov
ARCHITECTURE=amd64

# Set a Variables

SMBCLIENTEXE="/usr/bin/smbclient"
DIR_SOURCE_TREE=".\\Download\\Архивы\\$PRODUCT_CATEGORY\\$PRODUCT_NAME\\$PRODUCT_NAME_FOLDER\\"
INSTALL_SCRIPT=frp_$ARCHITECTURE.install.sh

# Check Integrity
#
if [ ! -x $SMBCLIENTEXE ]; then
    echo "Error Check Integrity! The file $SMBCLIENTEXE is not found!"
    exit 1
fi

# Run Payloads

if [ ! -d $HOME/packages/ ]; then
    mkdir $HOME/packages/
fi

if [ ! -d $HOME/packages/$FIRM_NAME/$PRODUCT_CATEGORY/$PRODUCT_NAME/$PRODUCT_NAME_FOLDER/ ]; then
    mkdir -p $HOME/packages/$FIRM_NAME/$PRODUCT_CATEGORY/$PRODUCT_NAME/$PRODUCT_NAME_FOLDER/
fi

cd $HOME/packages/$FIRM_NAME/$PRODUCT_CATEGORY/$PRODUCT_NAME/$PRODUCT_NAME_FOLDER/

$SMBCLIENTEXE -U $LOGINSTRING $PRODUCT_SOURCE_URL << SMBCLIENTCOMMANDS
recurse
prompt
cd $DIR_SOURCE_TREE
mget *
exit
SMBCLIENTCOMMANDS

if [ -f $HOME/packages/$FIRM_NAME/$PRODUCT_CATEGORY/$PRODUCT_NAME/$PRODUCT_NAME_FOLDER/$INSTALL_SCRIPT ]; then
    echo "Install Reverse proxy..."
    sudo /bin/bash $HOME/packages/$FIRM_NAME/$PRODUCT_CATEGORY/$PRODUCT_NAME/$PRODUCT_NAME_FOLDER/$INSTALL_SCRIPT
fi
rm *

echo "The End of the Script $0"
exit 0