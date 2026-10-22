#!/bin/bash
###########################################################
# nit.check-ifdevicein.003.sh
# This is a script for checking if device at home network
# Example of the keenetic entware script
# See https://forum.keenetic.ru/topic/2591-%D0%BE%D1%82%D0%BF%D1%80%D0%B0%D0%B2%D0%BA%D0%B0-%D0%BF%D0%BE%D1%87%D1%82%D0%BE%D0%B2%D0%BE%D0%B3%D0%BE-%D1%81%D0%BE%D0%BE%D0%B1%D1%89%D0%B5%D0%BD%D0%B8%D1%8F-%D0%BF%D1%80%D0%B8-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D0%BE%D1%82%D0%BA-%D0%BA%D0%BB%D0%B8%D0%B5%D0%BD%D1%82%D0%B0-wi-fi/
# https://forum.keenetic.ru/topic/4926-%D0%B7%D0%B0%D0%BF%D1%83%D1%81%D0%BA-%D1%81%D0%BA%D1%80%D0%B8%D0%BF%D1%82%D0%B0-%D0%BF%D1%80%D0%B8-%D0%BF%D0%BE%D1%8F%D0%B2%D0%BB%D0%B5%D0%BD%D0%B8%D0%B8-%D0%BD%D0%BE%D0%B2%D0%BE%D0%B3%D0%BE-%D0%BA%D0%BB%D0%B8%D0%B5%D0%BD%D1%82%D0%B0-wifi/#comment-58133
#
# The Script must be renamed e.g. 010-neighbour.sh
# and must be placed at /opt/etc/ndm/neighbour.d
# The Mosquitto client and jq packages must be installed
###########################################################

DEV1="a0:86:c6:8e:47:ef"
DEV2="74:23:44:bd:8f:86"

replacement() {
    case "$1" in
        *$DEV1* ) echo "Device 1";;
        *$DEV2* ) echo "Device 2";;
    esac
}

if [[ "$address" = "ipv4" && "$update" = "none" ]]; then
    #получаем mac устройства по ID
    mac=$(wget -qO - http://127.0.0.1:79/rci/show/ip/neighbour | jq --arg num "$id" '.[$num].mac')
    #проверяем mac на принадлежность нужному нам хосту
    who=$(replacement "$mac")
    [ -z "$who" ] && exit 0
    #публикуем mqtt сообщение типа "Device 1 new" и "Device 1 del" в топик zyxel
    mosquitto_pub -d -t zyxel -m "$who $action" -h 192.168.1.112 -p 1883 -u login -P password > /dev/null
fi