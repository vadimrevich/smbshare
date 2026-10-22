#!/usr/bin/env sh
###########################################################
# kali_compact.sh
# Compact the kali guest Virtual machine disk
###########################################################

### Run payloads... ###
#
dd if=/dev/zero of=/var/tmp/bigemptyfile bs=4096k
rm /var/tmp/bigemptyfile