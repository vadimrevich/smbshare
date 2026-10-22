#!/bin/bash
###########################################################
# nit.check-ifdevicein.002.sh
# This is a script for checking if device at home network
# Example of the keenetic entware script
# See https://forum.keenetic.ru/topic/2591-%D0%BE%D1%82%D0%BF%D1%80%D0%B0%D0%B2%D0%BA%D0%B0-%D0%BF%D0%BE%D1%87%D1%82%D0%BE%D0%B2%D0%BE%D0%B3%D0%BE-%D1%81%D0%BE%D0%BE%D0%B1%D1%89%D0%B5%D0%BD%D0%B8%D1%8F-%D0%BF%D1%80%D0%B8-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D0%BE%D1%82%D0%BA-%D0%BA%D0%BB%D0%B8%D0%B5%D0%BD%D1%82%D0%B0-wi-fi/
###########################################################

amac=$(ndmq -x -p "show associations" | grep "mac") #узнает кто авторизован по wifi

tmp=${amac//<mac>/}
tmp=${tmp//<\/mac>/} #убираем лишнее и оставляем чистый MAC

dev1="discon"
dev2="discon"

for cmac in $tmp
do
    if [ $cmac = "c1:31:b1:61:21:41" ] #забиваем нужный MAC
    then
        dev1="connected"
    fi
    if [ $cmac = "a1:e1:51:81:f1:21" ] #забиваем второй нужный MAC (для жены например)
    then
        dev2="connected"
    fi
done

if [ $dev1 = "connected" ]
then
    if [ ! -f /opt/etc/IPs/XperiaC4 ] #проверяем файл, если нет, то клиент вновь подключенный
    then
        echo -e "Subject: XperiaC4 connected\r\n\r\nClient XperiaC4 has been connected to Keenetic at $(date)" |/opt/bin/msmtp -t sample@gmail.com
        echo "$(date) Device XperiaC4 connect to Keenetic" >> /opt/tmp/log/chk_client.log
        touch "/opt/etc/IPs/XperiaC4"
    fi
else
    if [ -f /opt/etc/IPs/XperiaC4 ] #если файл есть, то клиент уже был подключен но отключился
    then
        echo -e "Subject: XperiaC4 disconnected\r\n\r\nClient XperiaC4 has been disconnected from Keenetic at $(date)" |/opt/bin/msmtp -t sample@gmail.com
        echo "$(date) Device XperiaC4 disconnect from Keenetic" >> /opt/tmp/log/chk_client.log
        rm "/opt/etc/IPs/XperiaC4"
    fi
fi

if [ $dev2 = "connected" ] #тоже самое для второго устройства
then
    if [ ! -f /opt/etc/IPs/T2Ultra ]
    then
        echo -e "Subject: T2Ultra connected\r\n\r\nClient T2Ultra has been connected to Keenetic at $(date)" |/opt/bin/msmtp -t sample@gmail.com
        echo "$(date) Device T2Ultra connect to Keenetic" >> /opt/tmp/log/chk_client.log
        touch "/opt/etc/IPs/T2Ultra"
    fi
else
    if [ -f /opt/etc/IPs/T2Ultra ]
    then
        echo -e "Subject: T2Ultra disconnected\r\n\r\nClient T2Ultra has been disconnected from Keenetic at $(date)" |/opt/bin/msmtp -t sample@gmail.com
        echo "$(date) Device T2Ultra disconnect from Keenetic" >> /opt/tmp/log/chk_client.log
        rm "/opt/etc/IPs/T2Ultra"
    fi
fi