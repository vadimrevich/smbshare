#!/usr/bin/env sh
###########################################################
# ub64_compact.sh
# Compact the Ub64 guest Virtual machine disk
###########################################################

### Run payloads... ###
#
dd if=/dev/zero of=/var/tmp/bigemptyfile bs=4096k
rm /var/tmp/bigemptyfile