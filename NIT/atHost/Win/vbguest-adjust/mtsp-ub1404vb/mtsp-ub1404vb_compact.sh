#!/usr/bin/env sh
###########################################################
# mtsp-ub1404vb_compact.sh
# Compact the mtsp-ub1404vb guest Virtual machine disk
###########################################################

### Run payloads... ###
#
dd if=/dev/zero of=/var/tmp/bigemptyfile bs=4096k
rm /var/tmp/bigemptyfile