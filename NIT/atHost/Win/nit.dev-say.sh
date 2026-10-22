#!/bin/bash
###########################################################
# nit.dev-say.sh
# The script will take device name and actions
# and will send message into mail, mosquitto and text log
#
# The Mosquitto client, msmtp and jq packages 
# must be installed on keenetic entware device
###########################################################

# Check arguments

if [ "$#" -ne 2 ];
then
    echo "Usage: $0 <device name> <action>" >&2; exit 1
fi

# Set variables

### Mosquitto settings ###
MQTTtopic="zyxel"
MQTThost="192.168.252.5"
MQTTport="1883"
MQTTlogin="admin"
MQTTpass="0A9s8d7F"
MQTTID="KEENETIC-9335"

### MSMTP Settings ###
MSMTP_ADDRESS="robots@clients.netip6.ru"

### Log file ###
LOGFILE="/opt/tmp/log/chk_client.log"
theDate=$(date +%Y-%m-%dT%H-%M-%S-%z)

### FTP Host ###
FTPHOST="reverse.netip4.ru"
FTPUSER="MSSQLSR"
FTPPASS="Admin01234"
FTPPORT="80"
REMOTEDIR="/tmp/RevMon/"
STAMPFILE="STAMP-DEVICE-$MQTTtopic.log"

aHostfile="http://$FTPHOST:$FTPPORT/$REMOTEDIR/"

### Messages ###
LOGMSG="Device $1 is $2 at $theDate to $MQTTtopic"
MSMTP_Subject="Subject: $LOGMSG"

# Run Payload

## MSMTP ##
##echo "$MSMTP_Subject" | /opt/bin/msmtp -t $MSMTP_ADDRESS

## Mosquitto ##
mosquitto_pub -d -t $MQTTtopic -m "$1 $2 $theDate" -h $MQTThost -p $MQTTport -u $MQTTlogin -P $MQTTpass -i $MQTTID >/dev/null 2>&1

# Logging
echo "$LOGMSG" >> $LOGFILE

## Send to FTP Host 
## curl -u $FTPUSER:$FTPPASS -T $LOGFILE $aHostfile$STAMPFILE

exit 0
