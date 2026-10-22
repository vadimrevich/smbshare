#!/bin/bash
###########################################################
# nit.check-deviceavailable.sh
# The script will check if device available at network
# It use ping and nmap packages
# It use only IPv4
#
# Checking ports:
# * 21/tcp (Linux, Windows)
# * 22/tcp (Linux, Windows)
# * 23/tcp (Linux)
# * 53/udp (Linux, Windows)
# * 80/tcp (Linix, Windows)
# * 135/tcp (Windows)
# * 137/udp (Windows)
# * 139/tcp (Linux, Windows)
# * 222/tcp (Linux, Windows)
# * 443/tcp (Linux, Windows)
# * 445/tcp (Linux, Windows)
# * 3389/tcp (Linux, Windows)
# * 5900/tcp (Linux)
# * 5901/tcp (Linux)
# * 5985/tcp (Windows)
#
# RETURNS:
# 0 if device available
# 1 otherwise
###########################################################

# Check a number of parameters

if [ "$#" -ne 1 ];
then
    echo "Usage: $0 <ipv4 address or fqdn>" >&2; exit 2
fi

# Set Variables

avail=1
ipv4=$1

ping -c 1 -w 2 -4 $ipv4 >/dev/null 2>/dev/null
if [ $? -eq 0 ]; then 
    avail=0
    echo "Ping is checking"    
fi

anIP=$(nmap -Pn --open -p 21 $ipv4 | grep -i "21/tcp")
if [ "$anIP" != "" ]; then 
    avail=0
    echo "21/tcp is open"    
fi

anIP=$(nmap -Pn --open -p 22 $ipv4 | grep -i "22/tcp")
if [ "$anIP" != "" ]; then 
    avail=0
    echo "22/tcp is open"    
fi

anIP=$(nmap -Pn --open -p 23 $ipv4 | grep -i "23/tcp")
if [ "$anIP" != "" ]; then 
    avail=0
    echo "23/tcp is open"    
fi

anIP=$(nmap -Pn -sU --open -p U:53 $ipv4 | grep -i "53/udp")
if [ "$anIP" != "" ]; then 
    avail=0
    echo "53/udp is open"    
fi

anIP=$(nmap -Pn --open -p 80 $ipv4 | grep -i "80/tcp")
if [ "$anIP" != "" ]; then 
    avail=0
    echo "80/tcp is open"    
fi

anIP=$(nmap -Pn --open -p 135 $ipv4 | grep -i "135/tcp")
if [ "$anIP" != "" ]; then 
    avail=0
    echo "135/tcp is open"    
fi

anIP=$(nmap -Pn -sU --open -p U:137 $ipv4 | grep -i "137/udp")
if [ "$anIP" != "" ]; then 
    avail=0
    echo "137/udp is open"    
fi

anIP=$(nmap -Pn --open -p 139 $ipv4 | grep -i "139/tcp")
if [ "$anIP" != "" ]; then 
    avail=0
    echo "139/tcp is open"    
fi

anIP=$(nmap -Pn --open -p 222 $ipv4 | grep -i "222/tcp")
if [ "$anIP" != "" ]; then 
    avail=0
    echo "222/tcp is open"    
fi

anIP=$(nmap -Pn --open -p 443 $ipv4 | grep -i "443/tcp")
if [ "$anIP" != "" ]; then 
    avail=0
    echo "443/tcp is open"    
fi

anIP=$(nmap -Pn --open -p 445 $ipv4 | grep -i "445/tcp")
if [ "$anIP" != "" ]; then 
    avail=0
    echo "445/tcp is open"    
fi

anIP=$(nmap -Pn --open -p 3389 $ipv4 | grep -i "3389/tcp")
if [ "$anIP" != "" ]; then 
    avail=0
    echo "3389/tcp is open"    
fi

anIP=$(nmap -Pn --open -p 5900 $ipv4 | grep -i "5900/tcp")
if [ "$anIP" != "" ]; then 
    avail=0
    echo "5900/tcp is open"    
fi

anIP=$(nmap -Pn --open -p 5901 $ipv4 | grep -i "5901/tcp")
if [ "$anIP" != "" ]; then 
    avail=0
    echo "5901/tcp is open"    
fi

anIP=$(nmap -Pn --open -p 5985 $ipv4 | grep -i "5985/tcp")
if [ "$anIP" != "" ]; then 
    avail=0
    echo "5985/tcp is open"    
fi

if [ $avail -eq 0 ]; then 
    echo "Device is available"
    exit 0
else 
    echo "Device is not available"
    exit 1
fi
