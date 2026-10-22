#!/usr/bin/env bash
###########################################################
# host.main.details.sh
# This Script will Print Main Host Details such us
# a hostname, a fqdn, Current User, IP address,
# External IP Address, Gateway, Name of System, Redaction
# and Save it into the File.
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
SUBPRODUCTNAME=sys.env.vars
FIRM_NAME=NIT

echo "### Check System Integrity ###"
###
if [ ! -f /etc/os-release ]; then
    echo "/etc/os-release is not found"
    exit 1
fi

if [ ! -e /bin/ping ]; then
    echo "/usr/bin/ping is not found"
    exit 1
fi

if [ ! -e /usr/bin/printf ]; then
    echo "/usr/bin/printf is not found"
    exit 1
fi

if [ ! -e /bin/hostname ]; then
    echo "/usr/bin/hostname is not found"
    exit 1
fi

if [ ! -e /sbin/ip ]; then
    echo "/usr/sbin/ip is not found"
    exit 1
fi

if [ ! -e /bin/grep ]; then
    echo "/usr/bin/grep is not found"
    exit 1
fi

if [ ! -e /usr/bin/cut ]; then
    echo "/usr/bin/cut is not found"
    exit 1
fi

if [ ! -e /usr/bin/curl ]; then
    echo "/usr/bin/curl is not found"
    exit 1
fi

if [ ! -e /bin/cat ]; then
    echo "/usr/bin/cat is not found"
    exit 1
fi

if [ ! -e /usr/bin/arch ]; then
    echo "/usr/bin/arch is not found"
    exit 1
fi

if [ ! -e /bin/uname ]; then
    echo "/usr/bin/uname is not found"
    exit 1
fi

if [ ! -e /usr/bin/hostnamectl ]; then
    echo "/usr/bin/hostnamectl is not found"
    exit 1
fi

if [ ! -e /usr/bin/xargs ]; then
    echo "/usr/bin/xargs is not found"
    exit 1
fi

if [ ! -e /bin/sed ]; then
    echo "/usr/bin/sed is not found"
    exit 1
fi

echo ""

###########################################################
# ext_interface()
# This Function wiil Get an Interface which is Connected
# with Internet
###########################################################
ext_interface () {
    for interface in /sys/class/net/*
    do
        [ "${interface##*/}" != 'lo' ] && \
            ping -c1 -W2 -I "${interface##*/}" 208.67.222.222 >/dev/null 2>&1 && \
                printf '%s' "${interface##*/}" && return 0
    done
}

#### Set a User Environment Variables #####
##
aHOSTNAME=$(hostname)
anFQDNSUFFIX=$(hostname -d)
# anFQDNSUFFIX="" # Test
aCURRENTUSER=$USER
anEXT_INTERFACE=$(ext_interface  | sed -n 1p)

if [ -n "$anEXT_INTERFACE" ]; then
    anINT_IPV4_ADDR=$(ip -4 addr show $anEXT_INTERFACE | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    anINT_IPV6_ADDR=$(ip -6 addr show $anEXT_INTERFACE | grep inet6 | grep 'scope link' | grep -oP '(?<=inet6\s)[\da-f:]+')
    anEXT_IPV4_ADDR=$(curl -s http://whatismijnip.nl | cut -d ' ' -f 5)
    anEXT_IPV6_ADDR=$(ip -6 addr show $anEXT_INTERFACE | grep inet6 | grep 'scope global' | grep -oP '(?<=inet6\s)[\da-f:]+' | sed -n 1p)
    aDEFGATEWAY_IPV4=$(ip route | grep default | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sed -n 1p)
    aDEFGATEWAY_IPV6=$(ip -6 route | grep default | grep -oE '(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))' | sed -n 1p)
fi

anOS_ID=$(cat /etc/os-release | grep -i "^ID=" | cut -d '=' -f 2-)
anOS_IDLIKE=$(cat /etc/os-release | grep -i "^ID_LIKE=" | cut -d '=' -f 2-)
anOS_VERSIONID=$(cat /etc/os-release | grep -i "^VERSION_ID=" | cut -d '=' -f 2-)
if [ -n "$WSL_DISTRO_NAME" ]; then
    if [ -d /run/WSL ]; then
        anOS_WSL=WSL2
    else
        anOS_WSL=WSL1
    fi
else
    anOS_WSL=Native
fi

anOS_Arch=$(arch)
anOS_KERNEL=$(uname -r)
if [ $anOS_WSL = 'Native' ]; then
    aHARDWARE_TYPE=$(hostnamectl | grep -i 'Icon name' | cut -d ':' -f 2 | xargs)
    aHARDWARE_ID=$(hostnamectl | grep -i 'Machine ID' | cut -d ':' -f 2 | xargs)
    aHARDWARE_CHAS=$(hostnamectl | grep -i 'Chassis' | cut -d ':' -f 2 | xargs)
    aBOOT_ID=$(hostnamectl | grep -i 'Boot ID' | cut -d ':' -f 2 | xargs)
    aHARDWARE_ARCH=$(hostnamectl | grep -i 'Architecture' | cut -d ':' -f 2 | xargs)
fi

if [ ! -n "$anFQDNSUFFIX" ]; then
    aFULLHOSTNAME=$aCURRENTUSER@$aHOSTNAME
else
    aFULLHOSTNAME=$aCURRENTUSER@$aHOSTNAME.$anFQDNSUFFIX
fi

# Run Payloads
#
echo "aHOSTNAME = $aHOSTNAME"
echo "aFullHostName = $aFULLHOSTNAME"

if [ -n "$anEXT_INTERFACE" ]; then
    echo "An External Interface = $anEXT_INTERFACE"
    echo "An Internal IPv4 Address = $anINT_IPV4_ADDR"
    echo "An Internal IPv6 Address = $anINT_IPV6_ADDR"
    echo "An External IPv4 Address = $anEXT_IPV4_ADDR"
    if [ -n "$anEXT_IPV6_ADDR" ]; then
        echo "An External IPv6 Address = $anEXT_IPV6_ADDR"
    else
        echo "An External IPv6 Address is not Assigned"
    fi
    echo "A Default IPv4 Gateway is $aDEFGATEWAY_IPV4"
    echo "A Default IPv6 Gateway is $aDEFGATEWAY_IPV6"
fi

echo "An OS $anOS_ID like $anOS_IDLIKE has Version $anOS_VERSIONID as $anOS_WSL"
echo "An OS Architecture is $anOS_Arch with a Kernel $anOS_KERNEL"

if [ $anOS_WSL = 'Native' ]; then
    echo "A Hardware Type is $aHARDWARE_TYPE and Chassis is $aHARDWARE_CHAS with Architecture $aHARDWARE_ARCH and ID $aHARDWARE_ID"
fi
