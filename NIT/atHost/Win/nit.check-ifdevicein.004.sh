#!/bin/bash
###########################################################
# nit.check-ifdevicein.004.sh
# This is a script for checking if device at home network
# Example of the keenetic entware script
# See https://forum.keenetic.ru/topic/2591-%D0%BE%D1%82%D0%BF%D1%80%D0%B0%D0%B2%D0%BA%D0%B0-%D0%BF%D0%BE%D1%87%D1%82%D0%BE%D0%B2%D0%BE%D0%B3%D0%BE-%D1%81%D0%BE%D0%BE%D0%B1%D1%89%D0%B5%D0%BD%D0%B8%D1%8F-%D0%BF%D1%80%D0%B8-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D0%BE%D1%82%D0%BA-%D0%BA%D0%BB%D0%B8%D0%B5%D0%BD%D1%82%D0%B0-wi-fi/
###########################################################

ndmq -x -p "show ip hotspot" | sed -n '/<mac>/p; /<name>/p' > /opt/var/names
ndmq -x -p "show associations"| grep "mac"  > /opt/var/present
/opt/bin/diff /opt/var/past /opt/var/present|grep "^[+-]"|grep -v "/opt/var/" > /opt/var/comp
while read line
do
  if test "${line:0:1}" = '+'; then
    action="Подключился"
  else
    action="Отключился"
  fi
  mac=${line//+}
  mac=${mac//-}
  name=$(grep -A 1 $mac /opt/var/names| grep -v mac)
  name=${name//<name>}
  name=${name//<\/name>}

  #Здесь шлем мыло, смс или ботом в телеграм с текстом: "$name $action"
  /opt/bin/tg_say.sh "$name $action" > /dev/null 2>/dev/null
done < /opt/var/comp
ndmq -x -p "show associations"| grep "mac"  > /opt/var/past

