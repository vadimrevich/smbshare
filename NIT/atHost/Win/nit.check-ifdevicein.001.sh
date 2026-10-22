#!/bin/bash
###########################################################
# nit.check-ifdevicein.000.sh
# This is a script for checking if device at home network
# Example of the keenetic entware script
# See https://forum.keenetic.ru/topic/2591-%D0%BE%D1%82%D0%BF%D1%80%D0%B0%D0%B2%D0%BA%D0%B0-%D0%BF%D0%BE%D1%87%D1%82%D0%BE%D0%B2%D0%BE%D0%B3%D0%BE-%D1%81%D0%BE%D0%BE%D0%B1%D1%89%D0%B5%D0%BD%D0%B8%D1%8F-%D0%BF%D1%80%D0%B8-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D0%BE%D1%82%D0%BA-%D0%BA%D0%BB%D0%B8%D0%B5%D0%BD%D1%82%D0%B0-wi-fi/
###########################################################

for ip in "192.168.101.20 T2Ultra" "192.168.101.23 XperiaC4" #IP и имя устройства, нужно вбить свои
do
    set -- $ip
    if /opt/bin/ping -c 1 -w 2 $1 >/dev/null 2>/dev/null; #тупо пингуем устройство
    then
        if [ -f "/opt/etc/IPs/$1" ] #проверяем наличие временного файла (если есть, клиент подключен)
        then
            echo "Device $2 ($1) still connected"
        else
            echo -e "Subject: $2 connected\r\n\r\nClient $2 ($1) has been connected to Keenetic at $(date)" |/opt/bin/msmtp -t sample@gmail.com #отправляем почту
            echo "$(date) Device $2 ($1) connect to Keenetic" >> /opt/tmp/log/chk_client.log #пишем в лог
            touch "/opt/etc/IPs/$1"
        fi
    else
        if [ -f "/opt/etc/IPs/$1" ]
        then
            echo -e "Subject: $2 disconnected\r\n\r\nClient $2 ($1) has been disconnected from Keenetic at $(date)" |/opt/bin/msmtp -t sample@gmail.com
            echo "$(date) Device $2 ($1) disconnect from Keenetic" >> /opt/tmp/log/chk_client.log
            rm "/opt/etc/IPs/$1"
        else
            echo "Device $2 ($1) is not connected"
        fi
    fi
done
