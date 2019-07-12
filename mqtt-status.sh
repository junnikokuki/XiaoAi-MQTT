#!/bin/sh
. /root/mqtt.conf

vol=0
info=""
status=""

while true
do
  volc=$(mphelper volume_get) 
  if [ $vol -ne $volc ]; then
    vol=$volc 
    /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/volume -r -m "$vol"
  fi
  infoc=$(ubus call mediaplayer player_get_context)
  if [ "$info" != "$infoc" ]; then  
    info=$infoc
    /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/info -r -m "$info"
  fi
  statusc=$(ubus call mediaplayer player_get_play_status)
  if [ "$status" != "$statusc" ]; then
    status=$statusc
    /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/status -r -m "$status"
  fi
  sleep $STATUSINTERVAL
done