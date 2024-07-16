#!/usr/bin/env bash
##########################
# bash_inventory.sh
# This Script will Inventory the Linux Computers
# at Laboratory Practicum
##########################
apt install -y lshw > /dev/null 2> /dev/null
echo "RAM              : $(free -h | awk  '/Mem:/{print $2}')
Bash version     : $(bash --version | head -1 | awk '{print $4}')
Java version     : $(java -version 2>&1 | head -1 | awk '{print $NF}' | sed 's/\"//g')
Operating System : $(uname -s)
OS version       : $(uname -v)
OS Virtualisation: $(egrep -c '(vmx|svm)' /proc/cpuinfo)
OS is 64-bit     : $(egrep -c ' lm ' /proc/cpuinfo)
Kernel is 64-bit : $(uname -m)
$(lsb_release -a)
Xen Virtualization:
$(cat /sys/hypervisor/properties/capabilities)
Is KVM Present?
$(kvm-ok)
$(lshw -class processor | grep -v 'capabilities:' | grep -v 'configuration:')
$(lscpu | grep -v 'Flags' | grep -v 'Vulnerability' | grep -v 'BogoMIPS' | grep -v 'cache' | grep -v 'Stepping' | grep -v 'Флаги' | grep -v 'Степпинг')
$(lsblk -o 'NAME,MAJ:MIN,RM,SIZE,RO,FSTYPE,MOUNTPOINT,UUID')
$(df -h)
"

