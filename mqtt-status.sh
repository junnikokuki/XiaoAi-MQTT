#!/bin/sh
. /root/mqtt.conf

while true
do
  /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/volume -r -m "$(mphelper volume_get)"
  /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/info -r -m "$(ubus call mediaplayer player_get_context)"
  /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/status -r -m "$(ubus call mediaplayer player_get_play_status)"
  sleep $STATUSINTERVAL
done